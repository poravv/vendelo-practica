class ApplicationController < ActionController::Base
    #Se incluyen todos los concerns 
    include Authentication
    include Authorization
    include Language
    include Pagy::Backend
    include Error
end