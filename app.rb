#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'localize/sinatra'
require 'helpers/application_helper'
require 'helpers/image_helper'
require 'helpers/url_helper'
require 'helpers/geo_helper'
require_relative './lib/repository'

configure do
  enable :sessions

  set :campaign, "arthritiscampaign"
  set :public_folder, Proc.new { File.join(root, "static") }

  set :flickr_api_key, ENV['FLICKR_API_KEY']
  set :flickr_user_id, ENV['FLICKR_USER_ID']
  set :flickr_secret, ENV['FLICKR_SECRET']
  set :flickr_access_token, ENV['FLICKR_ACCESS_TOKEN']
  set :flickr_access_secret, ENV['FLICKR_ACCESS_SECRET']
  set :flickr_photoset_id, ENV['FLICKR_PHOTOSET_ID']

  set :fb_app_id, ENV['FB_APP_ID']
  set :fb_app_secret, ENV['FB_APP_SECRET']
  set :google_api_key, ENV['GOOGLE_API_KEY']
  
  Localize.location = 'static/localization/'
  Localize.store = :yaml
end


before do
  language =  params['language'] || request.cookies['userLanguage'] || 'en'
  puts "***user language is #{language} for #{request.url}"
  set :language, language
  set :language_suffix, language == 'en' ? '' : "-#{language}"
  Localize.locale = language.to_sym
end

after do
  response.headers['X-Frame-Options'] = 'GOFORIT' 
  response.set_cookie("userLanguage", :value => settings.language, :expires => Time.new + 60*60*24) if(params['language'])

end

get '/' do
  haml :index
end

get '/admin' do
  submissions = Repository.submissions
  submissions.each do |submission|
    submission['photo_url'] = flickr.photo_url(submission['photo_id'])
    submission['photo_thumbnail_url'] = flickr.photo_thumbnail_url(submission['photo_id'])
  end
  haml :admin, :locals => { :submissions => submissions}, :layout => :simple_layout
end

post '/upload' do
  unless is_an_image? params[:photo]
    session[:error] = "Please, upload an image"
    redirect '/'
  end
  tempfile = params['photo'][:tempfile]
  file_name = tempfile.path
  user_img = resize(file_name)
  photo = add_logo(user_img, params[:banner])
  photo.write(file_name)

  photo_id = flickr.upload file_name

  geo = get_geo(request.ip)
  flickr.set_location photo_id, geo[0], geo[1]

  flickr.add_to_set photo_id
  Repository.save_submission({:first_name=> params[:first_name], :last_name=> params[:last_name],
  :phone=> params[:phone], :email=> params[:email], :photo_id=> photo_id, :timestamp => Time.new})
  redirect "/show/#{photo_id}?language=#{settings.language}"
end

get '/show/:photo_id' do
  haml :show, :locals => { :photo_url => flickr.photo_url(params[:photo_id]), :photo_id => params[:photo_id] }
end

get '/share/facebook/:photo_id' do
  callback_url = facebook_callback_url(params[:photo_id])
  session[:fb_message] = params[:message]
  puts "######## call back url ##################"
  puts callback_url
  redirect facebook.authorization_url(callback_url)
end

get '/share/facebook/message/:photo_id' do
  haml :facebook_message, :layout => :simple_layout, :locals => { :photo_id => params[:photo_id]}
end

get '/callback/facebook/:photo_id' do
  puts "############after callback  #{settings.language} ############# "
  photo = flickr.photo_url(params[:photo_id])
  callback_url = facebook_callback_url(params[:photo_id])
  facebook.share_photo(photo, session[:fb_message], params[:code], callback_url)
  session[:fb_message] = nil
  haml :facebook_shared, :layout => :simple_layout
end

get '/max_width' do
  content_type :json
  max_width_for(params[:width].to_i, params[:height].to_i, params[:banner_name]).to_json
end

get '/stylesheets/styles.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :styles
end
