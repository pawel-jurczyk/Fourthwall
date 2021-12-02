# Fourthwall
Lorem Picsum

1. What next steps that you'd take.
2. Remember to:
- following architecture patterns 
- providing sample unit tests
- creating detailed commit messages
3. Document the choices that you've made
4. Split commit history in sensible chunks.
5. iOS 13 or newer



## My decisions:
- Using AlamofireImage library: it has a good support for downloading, caching and updating UI once the download completes.
- CollectionView is a good choice when we want to present content with more then 1 column, so I'll use this one.

## Next to implement:
- Improve the constraints for the detail view. I've added modified autolayout constraints for landscape/portrait, but it's not perfect and it would take some more time to make look good.
- Some placeholder image for the downloading state or when the image download fails, so that the user knows what's going on
- Some refresh mechanism, so the user can retrigger the network call 
