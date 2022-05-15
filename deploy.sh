#bin/bash
echo "Auto Bot Host Script By Harsh."
echo "Moded by @IAm_Sandesh"
sleep 1
echo "Note- This Is Only For Master Branch."
sleep 1
appname=snake-t$RANDOM
if ! command -v heroku
then
    echo "Heroku could not be found"
    exit
fi
echo "Passing Fake Git UserName"
git config --global user.name Your Name
git config --global user.email you@example.com
echo "1. Type 1 If You Want To Host A New Bot."
echo "2. Type 2 If You Want To Update Old Bot."
read update 
if  ! [ "$update" == "2" ]
then 
echo "Hosting A New Bot"
if ! [ -f config.env ]
then 
    echo "Config Not Found" 
    exit
fi
echo -e "Making a New App\n"
echo -e "Want To Enter Your Own App Name? (Random Name:-$appname Will Be Selected By Default.)\n"
echo -e "Enter An Unique App Name Starting With Lowercase Letter.\n"
echo -e "Dont Enter Anything For Random App Name.(Just Press Enter And Leave It Blank.)\n"
read name
name="${name:=$appname}"
appname=$name
clear
echo -e "Choose The Server Region\n"
echo -e "Enter 1 For US\nEnter 2 For EU\n\nJust Press Enter For US Region(Default)"
read region
region="${region:=1}"
if [ $region == 1 ]
then
region=us
elif [ $region == 2 ]
then
region=eu
else
echo -e "Wrong Input Detected"
echo -e "US Server Is Selected"
region=us
fi
echo "Using $appname As Name."
echo "Using $region As Region For The Bot."
heroku create --region $region $appname
heroku git:remote -a $appname
heroku stack:set container -a $appname
echo "Done"
echo "Pushing"
if ! [ -d accounts/ ]
then
    git add .
    git add -f token.pickle config.env
    git commit -m "changes"
    git push heroku
    else
    echo "Pushing Accounts Folder Too"
    git add .
    git add -f token.pickle config.env accounts accounts/*
    git commit -m "changes"
    git push heroku
fi
sleep 2
clear
echo "Avoiding suspension."
sleep 2
echo "destroying Heroku app"
sleep 1
heroku apps:destroy --confirm $appname
sleep 2
echo "Creating new app"
sleep 2
heroku create --region $region $appname
heroku config:set BASE_URL_OF_BOT=https://"$appname".herokuapp.com
heroku git:remote -a $appname
heroku stack:set container -a $appname
echo "Done"
echo "Pushing"
if ! [ -d accounts/ ]
then
    git add .
    git add -f token.pickle config.env
    git commit -m "changes"
    git push heroku
    else
    echo "Pushing Accounts Folder Too"
    git add .
    git add -f token.pickle config.env accounts accounts/*
    git commit -m "changes"
    git push heroku
fi
heroku ps:scale web=0 -a $appname
heroku ps:scale web=1 -a $appname
echo "Enjoy"
else 
echo "Updating Bot."
git add .
if [ -d accounts/ ]
then
git add -f token.pickle config.env accounts accounts/*
git commit -m "changes"
git push heroku
heroku config:set BASE_URL_OF_BOT=https://"$appname".herokuapp.com
else
git add -f token.pickle config.env
git commit -m "changes"
git push heroku
heroku config:set BASE_URL_OF_BOT=https://"$appname".herokuapp.com
fi
fi
echo "Done"
echo "Type"
echo "heroku logs -t"
echo "To Check Bot Logs Here."
