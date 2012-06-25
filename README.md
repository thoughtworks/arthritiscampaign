# arthritiscampaign
App to allow users to embed the Arthritis campaign logo to their photos for use on social networks.
http://www.arthritis.ca

## Setup the Third Party Accounts
We need setup some third party accounts for our application.

### Flickr
This application uses Flickr API to store images on Flickr. We need a Flickr application for us. 

If you don't have Flickr account, please [create one](http://www.flickr.com/).

To get info of your Flickr application, you can goto [The App Garden](http://www.flickr.com/services/)

If you don't have Flickr application, you create one by goto [Get an API Key](http://www.flickr.com/services/apps/create/apply/)

Once your application created, you can click the link "App By You" which is on the right side of [The App Garden](http://www.flickr.com/services/). From there you can get your application's key and secret. Write down them for future use.

** Get your Flickr user ID **

Go to [http://idgettr.com/](http://idgettr.com/) and following the instruction to get your Flickr user ID. Write down it for future use.

### Facebook
This application uses a Facebook applicaton to post photos on users behalf. Certainly, when users share the photo on Facebook, users need authorize our Facebook application to post on users behalf.

If you don't have a Facebook account, please [create one](http://www.facebook.com/).

You can goto [Facebook Developer Center](https://developers.facebook.com/apps) to setup your Facebook applications.

To create a Facebook application, click "Create New App" on  the right top of the web page and follow the instruction to create one. During the process, give a name to the app. **Don't check "Yes, I would like free web hosting provided by Heroku" since our website cannot use the domain name provided by Heroku.** After you submit your creation request, you will be navigate to basic info page for the created app.

From the basic info page, **click "Mobile Web" section and fill in the "Mobile Web URL" with your website url**. For example, use "http://campaign.goriete.com/". Then click "Save Changes" to save your changes.

**Whenever our application's website URL has changed, please edit the Facebook applicaton to reset the "Mobile Web URL".**

I know, "Mobile Web URL" sounds wired. But it is the only way to give a custom URL to integrate with Facebook application at the moment when I write this document.

Please write down the Facebook application App ID and App Secret ID for future use.

###Google
This application uses Google Map javascript plugin to show the uploaded image geolocation info. We need a google application ID for the plugin.

If you don't have a google account, create one.

Go to [Google API console](https://code.google.com/apis/console). Click the left-top dropdown button and select "Create …" to create a new project. Give a name for the project. Click **"Google Maps API v3"** on service selection step.

After the project is created, go to "API Access" section on the left side. Under **"Simple API Access"** section, you should find API key info for this project. Write it down for future use.

### Google Analytics

You can got [Google Analytics](http://www.google.com/analytics/) to create an account and write down the analytics ID for future use.

###Heroku
We use Heroku to deploy this application.

If you don't have Hroke account, you need [create one](http://www.heroku.com/). 
You can follow the [Quick Start](https://devcenter.heroku.com/articles/quickstart) to install the Heroku toolbelt and log in to Heroku from command line.

##Setup Dev Environment
### Install Ruby
This application is a ruby application. We need install ruby 1.9.2 on your local dev machine. 

RVM is a good tool to install ruby on your machine for Linux or OX. Follow the instruction to [install RVM and ruby](https://rvm.io/rvm/install/). 

You can use [RubyInstaller](http://rubyinstaller.org/) to install ruby on Windows.

**If your dev machine is in a Widows environment, I strongly suggest to run a linux virtual machine to set up the ruby environment since it could be very painful to run ruby under windows even though it is dorable.**

### Install git
Our code repository is git and you must have git installed.  You can reference [http://git-scm.com/book/en/Getting-Started-Installing-Git](http://git-scm.com/book/en/Getting-Started-Installing-Git) to install it.

### Get the source code
You can run following command to get local readonly repository:

	>git clone git://github.com/thoughtworks/arthritiscampaign.git
	
You have ssh key setup for the github account, you can get a full permission repository using following command:

    >git clone git@github.com:thoughtworks/arthritiscampaign.git

After you get a local git repository, please go to the root folder of the repository:

	>cd arthritiscampaign
    
### Install ruby gem dependencies
Run the following command to install required ruby gem dependencies:

	>bundle install
	
### Get Flickr access token
If you do't have Flickr access token, go to [flickraw](https://github.com/hanklords/flickraw#authentication). Copy the ruby script in the code block and save it as a ruby file (for example, 'auth.rb'). **Make sure replace the flickr api key and secret in the script.** 
Run the script and following the output instruction to get access token and secret generate in the console output. Write down them for future use.

	>ruby auth.rb

	
### Setup local enviroment variables
If you are using Linux or OX, open/create ~/.bashrc file and append following lines:

	export FLICKR_API_KEY=your_flickr_key
	export FLICKR_SECRET=your_flickr_secret
	export FLICKR_ACCESS_TOKEN=your_flickr_access_token
	export FLICKR_ACCESS_SECRET=your_flickr_access_secret
	export FB_APP_ID=your_facebook_app_id
	export FB_APP_SECRET=your_facebook_secret
	export FLICKR_USER_ID=your_flickr_user_id
	export GOOGLE_ANALYTICS_ID=your_google_analytics_id
	export GOOGLE_API_KEY=your_goolge_api_key
	
**Replace all the keys with those we wrote down before in above lines.**

Save the file and run the command to make these environment variables in effect:

	>source ~/.bashrc
	
### Run the local ruby server
Now you can run the local ruby server to host our application:

	>ruby app.rb

Then you can open a web browser and goto http://localhost:4567 to see if the application is running. 

You can press Ctrl+C to stop the server from the command line.

## Deploy the application to Production

### Add heroku remote to git

If you want to create a Heroku application, please follow [the instruction](https://devcenter.heroku.com/articles/ruby#deploy_to_herokucedar).

The application has been accociated with a Heroku application at the moment when I write this post, so you don't need create the Heroku application but just add follow lines into .git/config file of your souce code repository folder:

	[remote "heroku"]
	url = git@heroku.com:smooth-mist-8780.git
	fetch = +refs/heads/*:refs/remotes/heroku/*
	
### Commit your local changes
	
After you making some change on the local source code, you can test it locallly to make sure it works. Then you can commmit the change to the local git repository and also push to the origin git remote repository:

	>git add .
	>git ci -m "you commit comment here"
	>git push

### Push changes to Heroku
Then you can push the changes to heroku to deploy the application to production:

	>git push heroku master

### View the logs
You can run following command to see the logs generated by web server:

	>heroku logs
	
### Change environment variables on Production
As you know, Heroku uses environment variables to store configuration settings. Reference [Heroku Config Vars](https://devcenter.heroku.com/articles/config-vars) for details.

For example, when you want to change your google API key, you can use following command:

	>heroku config:add GOOGLE_API_KEY=your_goolge_api_key

Heroku will reset the web server and the change will take in effect after teh resetting is done.

### Add custom domain to your website
When you want to add a custom domain to you website, you can do that though the Heroku toolbelt command line. Please reference [Custom Domains](https://devcenter.heroku.com/articles/custom-domains) for details.

For example, if you want to add http://newCampaign.arthritis.ca to your website, you can run following command:

	>heroku domains:add newCampaign.arthritis.ca
	
**Note: don't forget change your facebook application to update the "Mobile Web URL" as "http://newCampaign.arthritis.ca" for this new domain.**
	


## Change the Campaign message and images

### Change Flickr image tag
When you start a new campaign, you should change the Flickr image tag to make sure the new campaign use a different group of images.


Edit app.rb file under the source code repository root folder. Change the line:

	set :campaign, "arthritiscampaign"

to set the Flickr image tag.

### Change sharing messages
To change the sharing messages for Facebook, Twitter and Tumblr, edit "lib/helpers/application_helper.rb":

	def facebook_message
       settings.language == 'en' ?
         "Please support 4.6 million Canadians living with arthritis! Watch the video and share the infographic! http://www.goriete.com/page.aspx?pid=6324"
         : "S'il vous plaît soutenir 4,6 millions de Canadiens vivant avec l'arthrite! Regardez la vidéo et partager l'infographie! http://www.goriete.com/page.aspx?pid=6324"
    end

    def tumblr_message
      settings.language == 'en' ?
        "I support 4.6 million Canadians living with arthritis! Do you?"
        : "Je soutiens 4,6 millions de Canadiens vivant avec l'arthrite! Et vous?"
    end
     
    def twitter_message(photo_url)
      settings.language == 'en' ?
        "Please support 4.6 million Canadians living with arthritis! Watch the video and share the infographic! http://www.goriete.com/page.aspx?pid=6324"
        : "S'il vous plaît soutenir 4,6 millions de Canadiens vivant avec l'arthrite! Regardez la vidéo et partager l'infographie!"
    end

Change the return value of those three methods as shown in above code block in both English and French.

### Change banners

Goto "static/images/banners/" folder, you will see these files:

	banner1.png			
	banner2.png			
	banner3-small.png	
	banner1-fr.png	
	banner2-fr.png	
	banner3-small-fr.png
	banner1-thumb.png		
	banner2-thumb.png		
	banner3-small-thumb.png
	banner1-thumb-fr.png		
	banner2-thumb-fr.png		
	banner3-small-thumb-fr.png
	
This application has three banners. Each one has three images.

"bannerx.png" is the image embeded into the users photo when user's language is English. (X means 1 or 2 or 3. Same as below)

"bannerx-fr.png" is the image embeded into the users photo when user's language is French.

"bannerx-thumb.png" is the image shown in the uploading dialog.

Any banner whose name contains "small" will be embeded into the users phtoto with smaller size.

You can replace those images with new images but keep the same name conversions to change banners.

### Change other content of the web pages
There are three web pages and one css file under "views" folder you can change:
	
	index.haml	layout.haml	show.haml	styles.sass
	
	
layout.haml is the common view shared by index.haml and show.haml. 

"styles.sass" is the SASS file which will be automatically converted to CSS file by web server. 
	
	
After you make the local change, test it on the local server. When everything is good, you can push to github and push to Heroku to deploy to production.









