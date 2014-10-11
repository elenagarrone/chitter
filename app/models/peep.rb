class Peep

	include  DataMapper::Resource

	property :id, Serial
	property :message, Text
	property :time_peep, Time
	property :date, Text, :default => (Time.now.strftime("%H:%M - %d/%m/%Y"))

	validates_length_of :message, :in => (1..200)

end
