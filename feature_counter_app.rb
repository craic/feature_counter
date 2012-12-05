#!/usr/bin/env ruby

# feature_counter_app.rb

# Copyright 2012  Robert Jones  (jones@craic.com)   Craic Computing LLC
# This code and associated data files are distributed freely under the terms of the MIT license



require 'erb'
require 'open-uri'
require 'base64'


$:.unshift File.join(File.dirname(__FILE__))

class FeatureCounterApp < Sinatra::Base

  set :root, File.dirname(__FILE__)

  set :static, true


  get '/' do

    @error = ''
    @url = ''
    @image_type = ''
    if params['url']
      @url = params['url']
      if not @url =~ /^http/
        @error = "You did not enter a valid URL"
      end

      if @url =~ /\.jpe?g\s*$/i
        @image_type = 'jpeg'
      elsif @url =~ /\.png\s*$/i
        @image_type = 'png'
      elsif @url =~ /\.gif\s*$/i
        @image_type = 'gif'
      else
        @error = "Image URLs must end with jpg, png or gif - note that some web images use non-standard URLs" if @error == ''
      end
      # add the request IP before encoding to prevent direct use of the proxy action (s)
      @proxy_url = "/s?q=" + Base64.urlsafe_encode64(params['url'] + request.ip())
    end

    @url = '' if @error != ''

    erb :index
  end


  # proxy method to fetch images - this gets over the security restriction
  # that prevents saving the modified image if the original image comes from a different server
  # called 's' just to avoid obvious names like 'proxy'
  # BUT be very careful with a proxy - it could be used for nasty images, etc.

  get '/s' do

    valid_content_types = { "image/jpeg" => 1, "image/png" => 1, "image/gif" => 1 }

    @url = ''
    if params['q']
      str = Base64.urlsafe_decode64(params['q'])
      # this will only work if the current request IP is the same as the one used to create the url
      secret = request.ip()
      @url = str.sub!(/#{secret}$/, '')
#      STDERR.puts "URL   #{params['q']}"
#      STDERR.puts "decoded URL   #{@url}"
    end

    ct = ''
    data = open(@url, 'rb') {|f|
      ct = f.content_type
      f.read
    }

    # validate the content_type
    if valid_content_types[ct]
      content_type ct  # use the content_type helper
      data
    else
      # error message if an invalid type
      "Error: invalid image type"
      # return a error message image ?
    end
  end

end
