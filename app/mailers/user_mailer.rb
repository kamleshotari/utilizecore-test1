class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def status_email
    @parcel = params[:parcel]
    @sender = @parcel.sender
    @receiver = @parcel.receiver
    @url  = 'http://localhost:3000/search'
    mail(to: @receiver.email, cc: @sender.email,  subject: 'New Parcel Information')
  end

  def welcome_mail
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: 'User Registration')
  end

  def status_update
    @parcel = params[:parcel]
    @sender = @parcel.sender
    @receiver = @parcel.receiver
    @url  = 'http://localhost:3000/search'
    mail(to: @receiver.email, cc: @sender.email,  subject: 'Parcel Status Update')
  end
end
