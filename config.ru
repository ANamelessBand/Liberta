$:.unshift(File.expand_path('../lib', __FILE__))

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

map('/profile') { run ProfileController }
map('/') { run WebsiteController }