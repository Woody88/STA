class Shift < ActiveRecord::Base
  MIN_TIME = "00:00"
  MAX_TIME = "23:59" 
  belongs_to :profile
  has_many :for_trades, class_name: "ShiftForTrade", :foreign_key => "trade_id"

  attr_accessor :original_id # User to insert original shift record id 

  # include Workflow
  #   workflow do
  #       state :new do
  #           event :post, :transitions_to => :posted
  #           event :split_shift, :transitions_to => :partial 
  #           event :trade_request, :transitions_to => :pending_request
  #           event :shift_trade, :transitions_to => :shift_trade
  #       end

  #       state :available
  #       state :shift_trade do 
  #           event :sold, :transitions_to => :new
  #       end

  #       state :partial do
  #           event :post, :transitions_to => :posted
  #                        :unless => :split?
  #       end 
  
  #       state :posted do
  #           event :sold, :transitions_to => :traded
  #           event :cancel, :transitions_to => :new
  #           event :trade_request, :transitions_to => :pending_request
  #       end

  #       state :pending_request do 
  #          event :accept, :transitions_to => :traded
  #          event :decline, :transitions_to => :new
  #       end
  #       state :traded do 
  #           event :post, :transitions_to => :posted
  #           event :trade_request, :transitions_to => :pending_request
  #       end
  #   end

    def calendar_start_time
        start.change(day: date.day, month: date.month, year: date.year)
    end
    
    def calendar_end_time
        finish.change(day: date.day, month: date.month, year: date.year)
    end
    
    
    def overlaps?(shift)
        (start_time - shift.finish_time) * (shift.start_time - finish_time) > 0
    end
    
    def post!
        self.update_attributes!(:posted => true)
    end

    def unpost!
        self.update_attributes!(:posted => false)
    end 

    def unpartial!
      self.update_attributes!(:partial => false)
    end

    def is_partial?(original_shift)
      if start_time.eql?(original_shift.start_time) && finish_time.eql?(original_shift.finish_time)
        return false
      else
        return true
      end
    end       
end
