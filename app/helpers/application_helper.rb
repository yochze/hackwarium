# encoding: utf-8

module ApplicationHelper
	def object_creator_or_admin(object)
		if user_signed_in?
			if current_user == object.user || current_user.admin?
				true
			end
		end
	end

	def user_rank(user)
		if user.rank < 0
			("<div style=\'color: red; font-weight: bold;\'>" + user.rank.to_s + "</div>").html_safe
		elsif user.rank.blank?
			("<div style=\'color: green; font-weight: bold; display: inline;\'>" + '0' + "</div>").html_safe
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
		html << user.title if !user.title.blank?
		html << "</span>"
		html << "<br />"
		html << "ניקוד: "
		html << user_rank(user)
		html << "</div>"

		return html.html_safe
	end

  	def new_post
		if user_signed_in?
    		link_to 'פוסט חדש', new_post_path 
		end
  	end

  	def title(page_title)
    	content_for(:title){ page_title }
    	page_title
  	end
  	
end
