# encoding: utf-8

module PostsHelper
	def is_sticky(post)
		image_tag('/assets/badge.png') if post.sticky?
	end

  	def admin_panel_post(post)
  		if user_signed_in? && current_user.admin?
  			link_to 'מחק', post, :method => :delete, :class => 'edit_link', :confirm => 'האם אתה בטוח?'
			link_to 'סטיקי', post, :class => 'edit_link'
  		end
  	end

end
