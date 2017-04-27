class LoansPdf < Prawn::Document 
  def initialize(attend,attends,pessoa) 
    super(top_margin: 70, :page_size => "A4", :page_layout => :portrait) 
    @attend = attend
    @pp = attends 
    @pessoa = pessoa 
    
    titulo 
    documento 
    line_items 
    assinaturas 
    footer 
  end 

  

  def titulo 
    text "COMANDO DA AERONÁUTICA",:size => 14, :align => :center, :style => :bold 
    text "GRUPAMENTO DE APOIO DE CAMPO GRANDE",:size => 14, :align => :center, :style => :bold 
    text "ASSESSORIA DE TECNOLOGIA DA INFORMAÇÃO E COMUNICAÇÃO",:size => 14, :align => :center, :style => :bold 
    text "CAUTELA DE MATERIAL",:size => 14, :align => :center, :style => :bold 
    move_down 20    
  end 
 
  def documento 
    text "Declaro ter recebido os materiais informados abaixo, em perfeito estado, para que seja empregado, conforme Ordem de Serviço. Estou ciente que o mau uso ou a não utilização desse material para fim o informado, poderá acarretar em sanções administrativas conforme o RADA XXX   ", 
          :align => :justify 
    move_down 20 
    font_size(10) 
    data = [["Solicitante:",@attend.person(@attend.person_id)],
            ["Seção que pertence o material:",@attend.appointment.appointment_nome],  
            ["Data da solicitação:",@attend.data_saida.strftime('%d/%m/%Y')],                                     
            ["Pedido atendido por:",@attend.user.login(@attend.user.username)],             
            ["Obs:",@attend.obs] 
          ] 
    
    { :borders =>[:top]}.each do |property, value|           
        table(data,:cell_style =>{property => value},:position =>:left) 
      end      
  end 

  def line_items 
    move_down 20 
    text "LISTA DE MATERIAIS", :size => 14, :align => :left, :style => :bold 
    move_down 20 
    font_size(10) 
    table line_item_rows do 
      row(0).font_style = :bold 
      columns(1..15).align = :center 
      self.row_colors = ['DDDDDD', 'FFFFFF'] 
      self.header = true 
    end     
  end 

  def line_item_rows 
  	[["Produto","Descrição" ,"Quantidade", "Situação"]] + 
    @pp.map do |item| 
      [item.nome,item.descricao,item.qtde,item.situation.nome] 
  	end  	 
  end 

  def assinaturas 
    move_down 60 
    text "Campo Grande/MS, #{Time.now.strftime("%d/%m/%Y")}.", :align => :right 
    move_down 30 
    data = [["#{@attend.person_nome_completo(@attend.person_id)}"]]  

    move_down 10 
    { :borders =>[:top]}.each do |property, value|           
        table(data,:cell_style =>{property => value},:position =>:right) 
      end   

  end 

  def footer 
  	page_count.times do |i| 
        bounding_box([bounds.left, bounds.bottom], :width => bounds.width, :height => 30) { 
        # for each page, count the page number and write it 
        go_to_page i+1 
             move_down 5 # move below the document margin 
             text "#{i+1}/#{page_count}", :align => :center # write the page number and the total page count 
             text "Impresso por: #{@pessoa} em #{Time.now.strftime("%d/%m/%Y %H:%M")}", :align => :right 
        } 
    end 
  end 
 
end