module UsersHelper
	def users_chart_data
		users_by_day = User.total_grouped_by_day(3.weeks.ago)
		(3.weeks.ago.to_date..Date.today).map do |date|
			{
				users_at: date,
				total_sells: users_by_day[date.to_s] || 0
			}
		end
	end
end
