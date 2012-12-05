Image Feature Counter

This application is used to manually mark and count features in arbitrary images that can be accessed via a URL.

Uses for this include counting bacterial colonies in an image of a petri dish, specific cell types in histology slides
and counting buildings in satellite images.

It takes the form of a Ruby Sinatra application that fetches remote images and Javascript in the client web page that
implements the marking and counting functions.

The user can choose the shape and color of the marker. The current total is updated as features are clicked and the
coordinates of each point are stored internally.

The image with the user's marks can then be saved to a PNG format file and the list of coordinate pairs can be displayed in a separate window.

The live application is hosted at [Heroku](http://heroku.com) and can be accessed at [http://counter.craic.com](http://counter.craic.com)

The code is distributed freely under the terms of the MIT license and is archived at [Github](https://github.com/craic/feature_counter)

Copyright 2012 Robert Jones  jones@craic.com  [Craic Computing LLC](http://craic.com)



