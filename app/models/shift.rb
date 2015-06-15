class Shift < ActiveRecord::Base
  belongs_to :profile
  attr_accessor :original_id
  
  include Workflow
    
    workflow do
        state :new do
            event :post, :transitions_to => :posted
            event :trade_request, :transitions_to => :pending_request
            event :shift_trade, :transitions_to => :shift_trade
        end

        state :shift_trade do 
            event :sold, :transitions_to => :new
        end
        
        state :posted do
            event :sold, :transitions_to => :traded
            event :cancel, :transitions_to => :new
            event :trade_request, :transitions_to => :pending_request
        end

        state :pending_request do 
           event :accept, :transitions_to => :traded
           event :decline, :transitions_to => :new
        end
        state :traded do 
            event :post, :transitions_to => :posted
            event :trade_request, :transitions_to => :pending_request
        end
    end

    def calendar_start_time
        start.change(day: date.day, month: date.month, year: date.year)
    end
    
    def calendar_end_time
        finish.change(day: date.day, month: date.month, year: date.year)
    end
    
    
    def overlaps?(shift)
        (start_time - shift.finish_time) * (shift.start_time - finish_time) > 0
    end

end
