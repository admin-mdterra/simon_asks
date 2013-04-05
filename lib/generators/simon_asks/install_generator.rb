# Thanks to radar / forem
# The code used to inspire this generator!
require 'rails/generators'
module SimonAsks
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option "user_class", :type => :string
      class_option "no-migrate", :type => :boolean
      class_option "current_user_helper", :type => :string

      source_root File.expand_path("../install/templates", __FILE__)
      desc "Used to install SimonAsks"

      def install_migrations
        puts "Copying over SimonAsks migrations..."
        Dir.chdir(Rails.root) do
          `rake simon_asks:install:migrations`
        end
      end

      def determine_user_class
        @user_class = options["user_class"].presence ||
                      ask("What is your user class called? [User]").presence ||
                      'User'
      end

      def determine_current_user_helper
        current_user_helper = options["current_user_helper"].presence ||
                              ask("What is the current_user helper called in your app? [current_user]").presence ||
                              :current_user

#        puts "Defining simon_asks_user method inside ApplicationController..."

#        simon_asks_user_method = %Q{
#  def simon_asks_user
#    #{current_user_helper}
#  end
#  helper_method :simon_asks_user
#
#}

 #       inject_into_file("#{Rails.root}/app/controllers/application_controller.rb",
  #                       simon_asks_user_method,
  #                       :after => "ActionController::Base\n")

      end

      def add_simon_asks_initializer
        path = "#{Rails.root}/config/initializers/simon_asks.rb"
        if File.exists?(path)
          puts "Skipping config/initializers/simon_asks.rb creation, as file already exists!"
        else
          puts "Adding simon asks initializer (config/initializers/simon_asks.rb)..."
          template "initializer.rb", path
        end
      end

      def run_migrations
        unless options["no-migrate"]
          puts "Running rake db:migrate"
          `rake db:migrate`
        end
      end

      def seed_database
       # load "#{Rails.root}/config/initializers/simon_asks.rb"
       # unless options["no-migrate"]
       #   puts "Creating default forum and topic"
       #   Forem::Engine.load_seed
       # end
      end

      def mount_engine
        puts "Mounting SimonAsks::Engine at \"/qa\" in config/routes.rb..."
        insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
          %Q{
  mount SimonAsks::Engine => "/qa"

}
        end
      end

      def finished
        output = "\n\n" + ("*" * 53)
        output += %Q{\nDone! SimonAsks has been successfully installed!

Here's what happened:\n\n}

        output += step("SimonAsks' migrations were copied over into db/migrate.\n")
        #output += step("We created a new migration called AddForemAdminToTable.
   #This creates a new field called \"forem_admin\" on your #{user_class} model's table.\n")
        output += step("A new method called `forem_user` was inserted into your ApplicationController.
   This lets Forem know what the current user of your application is.\n")
      #  output += step("A new file was created at config/initializers/forem.rb
  # This is where you put Forem's configuration settings.\n")

        unless options["no-migrate"]
output += step("`rake db:migrate` was run, running all the migrations against your database.\n")
      #  output += step("Seed forum and topic were loaded into your database.\n")
        end
        output += step("The engine was mounted in your config/routes.rb file using this line:

   mount SimonAsks::Engine => \"/qa\"

   If you want to change where the forums are located, just change the \"/qa\" path at the end of this line to whatever you want.")
        output += %Q{\nAnd finally:

#{step("We told you that Forem has been successfully installed and walked you through the steps.")}}
       # unless defined?(Devise)
       #   output += %Q{We have detected you're not using Devise (which is OK with us, really!), so there's one extra step you'll need to do.
#
  # You'll need to define a "sign_in_path" method for Forem to use that points to the sign in path for your application. You can set Forem.sign_in_path to a String inside config/initializers/forem.rb to do this, or you can define it in your config/routes.rb file with a line like this:
#
  #        get '/users/sign_in', :to => "users#sign_in"
#
 #  Either way, Forem needs one of these two things in order to work properly. Please define them!}
 #       end
       # output += "\nIf you have any questions, comments or issues, please post them on our issues page: http://github.com/radar/forem/issues.\n\n"
       # output += "Thanks for using Forem!"
        puts output
      end

      private

      def step(words)
        @step ||= 0
        @step += 1
        "#{@step}) #{words}\n"
      end

      def user_class
        @user_class
      end

      def next_migration_number
        last_migration = Dir[Rails.root + "db/migrate/*.rb"].sort.last.split("/").last
        current_migration_number = /^(\d+)_/.match(last_migration)[1]
        current_migration_number.to_i + 1
      end
    end
  end
end