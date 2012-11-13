#!/bin/env ruby
# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "noreply@hackware.me"

   def welcome_email(user)
    @user = user
    @url  = 'http://f.hackware.me/sign_in'
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end
end
