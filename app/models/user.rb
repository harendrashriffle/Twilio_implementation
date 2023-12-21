class User < ApplicationRecord

  after_create :verify_by_sms

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,  stretches: 13

  validates :name, length: {minimum: 3}, presence: true
  validates :email, uniqueness: {case_sensitive: false}, presence: true
  # validates :encrypted_password, length: {minimum: 4}
  validates :type, inclusion: { in: ['Owner', 'Customer']}
  validates :mobile, length: {is: 10}, uniqueness: true, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "confirmation_sent_at", "confirmation_token", "confirmed_at", "created_at", "email", "encrypted_password", "id", "mobile", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "type", "unconfirmed_email", "updated_at"]
  end

  private
    def verify_by_sms
      # byebug
      send_sms("+91#{self.mobile.to_i}","Please Verify you Swiggy using the OTP")
    end

    def send_sms(mobile,msg)
      byebug
      require 'twilio-ruby'
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      api_key_sid = ENV['API_KEY_SID']
      api_key_secret = ENV['API_KEY_SECRET']
      @client = Twilio::REST::Client.new(account_sid, auth_token)
      # @client = Twilio::REST::Client.new api_key_sid, api_key_secret, account_sid
      message = @client.messages.create(
        from: '+12059272613',
        to: mobile,
        body: msg
      )
      puts message.sid
    end
end
