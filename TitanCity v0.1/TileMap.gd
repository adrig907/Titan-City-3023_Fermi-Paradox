extends TileMap

var xGridSize=4
var yGridSize=3
var Dic={}
var tile = null
var selected = null
var _timer = null
var ohm=1.1;
var upgrade=false

var food = 50;
var materials=10;
var energy = 50;
var oxygen = 50;

func _ready():
	$ConsumeTime.start()
	$GenerateTime.start()
	$Generate_energy.start()
	
	
	for x in xGridSize:
		for y in yGridSize:
			Dic[(str(Vector2(x+1,y+3)))]={
				"Type":'Buildable',
				"Level":'0'
			}
			set_cell(0, Vector2(x+1, y+3), 0,Vector2i(0,0), 0);
	
	Dic[str("(1, 3)")].Type="Energy Plant";
	#set_cell(0, Vector2i(1,3), 3,Vector2i(0,0), 0)
	
	Dic[str("(2, 3)")].Type="Farm";
	#set_cell(0, Vector2i(2,3), 2,Vector2i(0,0), 0)
	
	#Barras de Progreso
	$Food2.value=food;
	$Electricity2.value=energy;
	$O3.value=oxygen;
	



	
	

func _process(delta):
	if Input.is_key_pressed(KEY_D):
		upgrade = true;
	drawBuilding(Dic);
	if(selected != null):
		if(selected[0]>=5||selected[1]>=6||selected[0]<1||selected[1]<3):
			selected=null

	tile = local_to_map(get_global_mouse_position())
	if Dic.has(str(tile)):
		
		#Recorre el diccionario y lo dibuja
		if(selected==null):
			drawBuilding(Dic);
		
		if selected!=null:
			set_cell(1,selected,1, Vector2i(0,0),0)
			
		#Esto debería ser un switch pero cosas de Godot
		if Input.is_key_pressed(KEY_1)&&selected:
			var sel =Vector2i(selected[0], selected[1])
			Dic[str(selected)].Type="Lab"
			selected=null;
			
		if Input.is_key_pressed(KEY_2)&&selected:
			var sel =Vector2i(selected[0], selected[1])
			Dic[str(selected)].Type="Farm"
			selected=null;
			
		if Input.is_key_pressed(KEY_3)&&selected:
			var sel =Vector2i(selected[0], selected[1])
			Dic[str(selected)].Type="Energy Plant"
			selected=null;

	
	$Food2.value=food;
	$Electricity2.value=energy;
	$O3.value=oxygen;
	

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if !selected:
			selected = tile
			
		elif selected:
			if(tile[0]>=5 ||  tile [1]>=6||tile[0]<1 ||  tile [1]<3):
				selected=null

func drawBuilding(Dic):
	
	for x in range(1,5):
				for y in range(3,6):
					var pos=Dic[str("(",x,", ", y,")")]
					match pos.Type:
						"Buildable":
							set_cell(1, Vector2(x, y), 0,Vector2i(0,0), 0)
						"Farm":
							set_cell(1, Vector2(x, y), 2,Vector2i(0,0), 0)
						"Lab":
							set_cell(1, Vector2(x, y), 3,Vector2i(0,0), 0)
						"Energy Plant":
							if(upgrade==false):
								set_cell(1, Vector2(x, y), 5,Vector2i(0,0), 0)
							if (upgrade==true):
								set_cell(1, Vector2(x, y), 4,Vector2i(0,0), 0)
						
	
		


func _on_consume_time_timeout():
	

	var buildings=12;
	for x in range(1,5):
		for y in range(3,6):
			var pos=Dic[str("(",x,", ", y,")")]
			match pos.Type :
				"Buildable":
					buildings=buildings-1
	food=food-2;
	energy=energy-buildings
	if(food<=0):
		food=0
		print("you died");
		$GenerateTime.stop();
		$ConsumeTime.stop();
	
func _on_generate_time_timeout():
	var farms=0;
	for x in range(1,5):
				for y in range(3,6):
					var pos=Dic[str("(",x,", ", y,")")]
					if(pos.Type=="Farm"):
							farms=farms+1
	food = food+6*farms;

	if(food>100):
		food=100;



func _on_generate_energy_timeout():
	var power=0;
	for x in range(1,5):
				for y in range(3,6):
					var pos=Dic[str("(",x,", ", y,")")]
					if(pos.Type =="Energy Plant"):
							power=power+1*1.1
	#print(power)
	energy=energy+power
