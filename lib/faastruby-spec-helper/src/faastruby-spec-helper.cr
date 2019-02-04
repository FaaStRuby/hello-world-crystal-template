require "yaml"
require "json"
require "base64"
require "./modules/spec_helper"

# TODO: Write documentation for `Faastruby::Spec::Helper`

module FaaStRuby
  VERSION = "0.1.0"
  include FaaStRuby::SpecHelper
end