module ApplicationHelper

	class MarkdownRenderer < Redcarpet::Render::HTML
		def block_code(code, language)
			CodeRay.highlight(code, language, options = {
				:line_numbers => :inline,
				:line_number_anchors => false,
				:break_lines => true,
				:wrap => :page
				})
		end
	end

	def markdown(text)
		renderer = MarkdownRenderer.new(:filter_html => true, :hard_wrap => true)
		options = {
			disable_indented_code_blocks: true,
			fenced_code_blocks: true,
			:no_intra_emphasis => true,
      :autolink => true,
		}
  	markdown = Redcarpet::Markdown.new(renderer, options)
  	markdown.render(text).html_safe
  end

end
