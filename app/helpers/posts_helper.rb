module PostsHelper
	def is_sticky(post)
		image_tag('/assets/badge.png') if post.sticky?
	end


end
