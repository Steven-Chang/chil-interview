# frozen_string_literal: true

module CommentsHelper
	def comments_container_class(commentable)
		container_class = ""
		container_class += "mt-5" unless commentable.class == Comment
		"#{container_class} pl-3 ml-3 border-left" if commentable.class == Comment
	end

	def comments_container_id(commentable)
		"#{commentable.class.to_s.downcase}-#{commentable.id}-comments"
	end

	def comment_form_classes(commentable)
		"d-none" if commentable.class == Comment
	end

	def comment_form_id(commentable)
		"#{commentable.class.to_s.downcase}-#{commentable.id}-comment-form"
	end
end
