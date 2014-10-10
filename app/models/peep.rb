class Peep

	include  DataMapper::Resource

	property :id, Serial
	property :message, Text
	# property :order_peep, Time
	property :date, Text, :default => (Time.now.strftime("%H:%M - %d/%m/%Y"))

end
