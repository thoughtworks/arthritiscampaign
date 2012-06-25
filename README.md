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

If you don't have Hroke account. You need [create one](http://www.heroku.com/). You can read the [Quick Start](https://devcenter.heroku.com/articles/quickstart) to get some basic idea how Heroku works.

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
under construction...

## Change the campaign message and images

under construction...








