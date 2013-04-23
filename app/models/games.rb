class Games < ActiveRecord::Base
   attr_accessible :x_token, :session_token, :o_token, :last_played_owner, :last_column, :last_row
end
