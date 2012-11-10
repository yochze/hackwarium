module ApplicationHelper
	def object_creator_or_admin(object)
		if current_user == object.user || current_user.admin?
			true
		end
	end
end
