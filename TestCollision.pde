ArrayList<Collidable> collidables ;

void setup(){
  fullScreen() ;
  frameRate(30) ;
  collidables = new ArrayList<Collidable>() ;
  for( int k = 0 ; k < 500 ; ++k ){
    collidables.add( new Ball( random(width) , random(height) , 5 , color(int(random(255)),int(random(255)),int(random(255))) ) ) ;
    float agl = random(TAU) ;
    float speed = 5.6 ;
    collidables.get(k).speed.set( speed*cos(agl) , speed*sin(agl) ) ;
  }
  collidables.add( new Wall( width/2 , -25 , width , 50 ) ) ;
  collidables.add( new Wall( width/2 , height+25 , width , 50 ) ) ;
  collidables.add( new Wall( -25 , height/2 , 50 , height ) ) ;
  collidables.add( new Wall( width+25 , height/2 , 50 , height ) ) ;
}

void draw(){
  noStroke() ;
  fill( 0 , 132 ) ;
  rectMode( CORNER ) ;
  rect(0,0,width,height) ;
  for( int k = 0 ; k < collidables.size() ; ++k ){
    Collidable obj = collidables.get(k) ;
    obj.move() ;
    for( int l = k+1 ; l < collidables.size() ; ++l ){
      obj.checkAndSolveCollision( collidables.get(l) ) ;
    }
    obj.show() ;
  }
  //saveFrame( "film/#####.tiff" ) ;
}
