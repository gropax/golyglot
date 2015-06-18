class User < ActiveRecord::Base
  include BCrypt

  #has_many :lexicons

  attr_accessor :password, :password_confirmation

  before_save :encrypt_password

  def authenticate(password)
    Password.new(password_hash) == password
  end

  protected

  def encrypt_password
    self.password_hash = Password.create(@password)
  end

  validates_presence_of :name, message: "Username is Required."
  validates_uniqueness_of :name, message: "Username Already Exists."
  validates_presence_of :email, message: "Email Address is Required."
  validates_uniqueness_of :email, message: "Email Address Already In Use."
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i, message: "Invalid Email Address."
  validates_length_of :password, :minimum => 8, message: "Password Must Be Longer Than 8 Characters."
  validates_confirmation_of :password, message: "Password Confirmation Must Match Given Password."
end
