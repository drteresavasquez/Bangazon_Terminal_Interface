#PAYMENT CONTROLLER
# Author: Dev Team
# Contains methods that allows user to add payment option to active customer.

require 'store'
require 'sqlite3'

class Payment

    attr_accessor :name, :account

    def initialize(name:, account:)
        @name = name
        @account = account
    end


    def self.add_payment_to_active_customer
        system "clear" or system "cls"
        puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"

        print "Would you like to proceed with this active customer? "
        proceed = gets.upcase.chomp

        if proceed == "Y" 
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Add a payment option **")
            add_payment = self.add_payment_option
            
        else
            ActiveCustomer.list
            system "clear" or system "cls"
            puts "ACTIVE Customer ID: #{$ACTIVE_CUSTOMER_ID} | Name: #{$ACTIVE_CUSTOMER[:name_first]} #{$ACTIVE_CUSTOMER[:name_last]}\n\n"
            output_action_header("** Add a payment option **")
            add_payment = self.add_payment_option
            
        end

        if add_payment.save_payment
            system "clear" or system "cls"
        else
            puts "SAVE ERROR:payment not added"
        end
    end


    def self.add_payment_option
        args = {}
        print "Enter payment type (e.g. AmEx, Visa, Checking) "
        args[:name] = gets.chomp.upcase.strip

        print "Enter account number "
        args[:account] = gets.chomp.upcase.strip
        return self.new(args)
    end

    def save_payment
        return false unless DatabaseAdmin.file_useable?
        db = SQLite3::Database.open("bangazon_store.sqlite")
        db.execute("INSERT INTO payments(name, account, customer_id) VALUES(?, ?, ?)", ["#{name}", "#{account}", "#{$ACTIVE_CUSTOMER_ID}"])
        #Add active customerId to table
        db.close
        return true
    end

    def self.output_action_header(text)
        puts "#{text.upcase.center(60)}"
    end

end