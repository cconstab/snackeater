# snackeater
 Send Snacks demo using the @platform

 Simple demo app showing the power of the @platform to send information from one person to another full encrypted.

  In this case we send a snack and when it is recieved we pop up a snack bar widget..

![image](https://user-images.githubusercontent.com/6131216/142484446-d16c2d23-9d82-4f55-9815-5b7e734d54fb.png)

  #
  Quick note.. When you run this for the first time in debug mode you will have to play over the fact you have no @sign yet. Nothing is broken just the IDE letting you know.. It's just a demo :-)

  # How does it work ?

  In the .env file we set up a namespace for the application. The namespace is an @sign that I own hence I own the namespace (it was a free one). Need an @sign ? Get one for free at atsign.com or in the app when you run it get a free one or two.

  The application asks the person using it to onboard using their @sign, or if this is already set up it goes to the FirstAppScreen. From this screen you can see the onboarded @sign and type in which @sign you want to send a snack to.

  When you send a snack all you actually have to do is share a key/value pair with the @sign.. This is the magic line of code:-  

  ` await atClient.put(key, snacks[Random().nextInt(snacks.length)]);`  

  This put's a value in this case a random snack bar into a key. The key is set up just before this line and tells the put who to share the data with plus who to notify that they have new data to pick up. The who is always an @sign on the @platform.  
  ```
     var metaData = Metadata()
    ..isPublic = false
    ..isEncrypted = true
    ..namespaceAware = true
    ..ttl = 100000;


    var key = AtKey()  
    ..key = 'snackbar'  
    ..sharedBy = currentAtsign  
    ..sharedWith = sendSnackTo  
    ..metadata = metaData;  
``` 

The app can both send snacks a recieve them, to recieve we open up a notification service, that looks for notifications in the applications namespace and we also set up the code block to run when the notification triggers. 

```
var notificationService = atClientManager.notificationService;
    notificationService.subscribe(regex: AtEnv.appNamespace).listen((notification) {
      getAtsignData(context, notification.key);
    });
```
In our case we just want a snackbar widget to pop up so we send to the getAtsignData method the context of the screen and the notification.key object that contains details of the notification.  
Once in getAtsignData we do some string manipulation and then get the snackbar with a simple get call.  

`var snackKey = await atClient.get(key);`  

Once again we had to set up some basic information for the key with this code:-  
  
  ```
    var metaData = Metadata()
    ..isPublic = false
    ..isEncrypted = true
    ..namespaceAware = true;

  var key = AtKey()
    ..key = keyAtsign
    ..sharedBy = sharedByAtsign
    ..sharedWith = currentAtsign
    ..metadata = metaData;
```
  
  We now have the data from the send containing our snack, so we display it with the snackbar widget.

  `ScaffoldMessenger.of(context).showSnackBar(snackBar);`  

  It really is that simple to send a fully End to End Encrypted message from on e @sign to another using the @platform..

  Get a couple of @signs and send a snack ! Better still get a friend to get an @sign and send them a snack !

  ## PR's and improvements
  Want to add you favorite snack ? Raise a PR!, Want to improve my code ? Cool raise a PR ? Got a bug ? Cool raise an issue or better still a PR.
  Have fun trying the @platform..
 
  Send me a snack!

  @colin






