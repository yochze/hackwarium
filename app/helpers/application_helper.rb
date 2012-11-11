# encoding: utf-8

module ApplicationHelper
	def object_creator_or_admin(object)
		if current_user == object.user || current_user.admin?
			true
		end
	end

	def user_rank(user)
		if user.rank < 0 
			("<div style=\'color: red; font-weight: bold;\'>" + user.rank.to_s + "</div>").html_safe
		else
			("<div style=\'color: green; font-weight: bold; display: inline;\'>" + user.rank.to_s + "</div>").html_safe
		end
	end

	def tooltip_user(user)
		html = ""
		html << "<img src=" + user.profile_pic + " class=\'tooltip_image\' />"
		html << "<div class=\'tooltip_text\'>"
		html << user.name
		html << "<br />"
		html << "<span class=\'tooltip_user_quote\'>"
		html << user.title
		html << "</span>"
		html << "<br />"
		html << "ניקוד: "
		html << user_rank(user)
		html << "</div>"

		return html.html_safe
	end


	def did_you_know
		html = []
		html << "חוק אוהם התגלה ב־1826 על ידי גאורג אוהם, והוא מציג קשר פשוט ועם זאת חשוב בין המתח, הזרם וההתנגדות החשמלית בחומרים מסוימים. חוק אוהם הוא אחד החוקים הבסיסים ביותר בתורת המעגלים החשמליים."
		html << "asdf"
		return html.sample
	end
end
