require "mechanize"
namespace :wishes do
  task :add => :environment do
    active_users = User.all.includes(:wish, :credential)
    active_users.each do |user|
      print "Processing user: #{user.credential.username}"

      agent = Mechanize.new
      begin
        login_page = agent.get("http://mbasic.facebook.com")
      rescue => e
        print e
        next
      end
      print "Trying to loggin"
      login_form = login_page.form_with(:method => 'POST')
      login_form.email = user.credential.username
      print "\n #{user.credential.username}"
      crypt =  ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
      decrypted_pass = crypt.decrypt_and_verify(user.credential.password)

      login_form.pass = decrypted_pass

      # button = login_form.button_with(:name => "btnLogin")
      print "About to login\n"
      landing_page = agent.submit(login_form)
      sleep 5.0

      begin
        bday_page = agent.get('http://mbasic.facebook.com/browse/birthdays/?rdr')
      rescue => e
        print e
        next
      end

      print "Trying To Post"
      while form = bday_page.form_with(:method => 'POST')
        form.message = user.wish.wish
        agent.submit(form)
      end
    end

  end
end