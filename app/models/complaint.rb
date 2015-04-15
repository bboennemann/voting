class Complaint
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to  	:user

  field :user_id, 	type: String

  field :item_type, type: String
  field :item_id,	type: String
  field :reason, 	type: String

  REASONS = {
  	"spam" 			=> "It is spam.", 
  	"violence" 		=> "It displays violence.", 
  	"porn"			=> "It is pornographic.",  	
  	"illegal"		=> "It shows illegal activities.",  	
  	"disagree"		=> "It is against my views.", 
  	"in_it" 		=> "I am in it, against my will.", 
  	"other" 		=> "I just think it should not be here." 
  }

end
