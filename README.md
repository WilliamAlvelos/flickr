# Flickr

## Brief

### Develop a native mobile app which uses the Flickr API to display a list of photos.

✅ The app should display a list of photos, along with the poster's userid and user icon. 

✅ The app should display alongside the photo a list of any tags associated with the photo. (I'm only diplaying 4 tags so it looks good on the layout)

✅ Tapping on the photo should take the user to a separate page wherein they can see more detail about the photo (e.g. Title, date take, any content description, etc.)

✅ Tapping on a user id/photo should produce a list of photos by that user. 

✅ There should be a default search of "Yorkshire" on first load and safe_search should be set to safe.

## Additional Features

✅ The app should be able to search for Photos by tag or lists of tags, and provide whether a photo should contain all or some tags

✅ The app could allow for searching for a user's photos by their username


## Requirements

The app was developed on Xcode 15.0 and has a minimum target of iOS 17.0. 
The APIKeys.plist has the api_key needed to run the application, you can try to replace it but make sure your api_key has access to the method flickr.people.search, otherwise the app will work fully apart from the user search.

## Next Steps

- Fetch and display photo comments when the user is on the photo detail.
- Fetch and display discussions, photos, and members from the group on the group detail.
- Move base image URL and API base URL inside a config file.
- Add PhotosRequestSort on the photo search list.

## Architecture
It was decided to use MVVM, because the separation of concerns is clear, enabling better maintainability and testability.

## Screenshots
The app should work in both dark mode and light mode, so feel free to use the one you prefer 📱.

## CI
There is a GitHub Action responsible for running the tests of the application, ensuring that no branches are failing. 🚀
