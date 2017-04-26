module ApplicationHelper
	def error_tag(model, attribute)
		if model.errors.has_key? attribute
			content_tag(
				:div,
				model.errors[attribute].first,
				class: 'error_message'
				)
		end
	end
	def lista_estados_helper
    [
        ['AC'],
        ['AL'],
        ['AM'],
        ['AP'],
        ['BA'],
        ['CE'],
        ['DF'],
        ['ES'],
        ['GO'],
        ['MA'],
        ['MG'],
        ['MS'],
        ['MT'],
        ['PA'],
        ['PB'],
        ['PE'],
        ['PI'],
        ['PR'],
        ['RJ'],
        ['RN'],
        ['RO'],
        ['RR'],
        ['RS'],
        ['SC'],
        ['SE'],
        ['SP'],
        ['TO']  

    ]
    end
    def cnh_cat_helper
    [
        ['A'],
        ['AB'],
        ['AC'],
        ['AD'],
        ['AE'],
        ['B'],
        ['C'],
        ['D'],
        ['E']
    ]
    end

end
