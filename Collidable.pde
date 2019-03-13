class Collidable{
  PVector pos ;
  PVector prevPos ;
  PVector speed ;
  float w ;
  float h ;
  
  Collidable( float x , float y , float w , float h ){
    pos = new PVector( x , y ) ;
    prevPos = new PVector( x , y ) ;
    speed = new PVector( 0 , 0 ) ;
    this.w = w ;
    this.h = h ;
  }
  
  boolean xCollidesWith( Collidable obj ){
    return abs( pos.x - obj.pos.x ) < w/2 + obj.w/2 ;
  }
  
  boolean yCollidesWith( Collidable obj ){
    return abs( pos.y - obj.pos.y ) < h/2 + obj.h/2 ;
  }
  
  boolean collidesWith( Collidable obj ){
    return xCollidesWith(obj) && yCollidesWith(obj) ;
  }
  
  boolean xCollidedWith( Collidable obj ){
    return abs( prevPos.x - obj.prevPos.x ) < w/2 + obj.w/2 ;
  }
  
  boolean yCollidedWith( Collidable obj ){
    return abs( prevPos.y - obj.prevPos.y ) < h/2 + obj.h/2 ;
  }
  
  void checkAndSolveCollision( Collidable obj ){
    if( collidesWith( obj ) ){
      //Change position
      pos.set( prevPos ) ;
      obj.pos.set( obj.prevPos ) ;
      //Change speed
      if( xCollidedWith( obj ) ){
        speed.y *= -1 ;
        obj.speed.y *= -1 ;
      }
      else{
        speed.x *= -1 ;
        obj.speed.x *= -1 ;
      }
      //Resolve objects intersecting
      while( xCollidedWith(obj) && yCollidedWith(obj) ){
        move() ;
      }
    }
  }
  
  void moveTo(float x , float y){
    prevPos.set( pos ) ;
    pos.set( x , y ) ;
  }
  
  void move(){
    moveTo( pos.x + speed.x , pos.y + speed.y ) ;
  }
  
  void show(){
    
  }
}

class Ball extends Collidable{
  color colour ;
  float r ;
  
  Ball( float x , float y , float r , color colour ){
    super( x , y , 2*r , 2*r ) ;
    this.r = r ;
    this.colour = colour ;
  }
  
  void show(){
    noStroke() ;
    fill( colour ) ;
    ellipse( pos.x , pos.y , r*2 , r*2 ) ;
  }
}

class Wall extends Collidable{
  Wall( float x , float y , float w , float h ){
    super( x , y , w , h ) ;
  }
  
  void show(){
    rectMode( CENTER ) ;
    noStroke() ;
    fill( 200 ) ;
    rect( pos.x , pos.y , w , h ) ;
  }
}
