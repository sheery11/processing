class Particle
{
  float _radius,_rot,_scl;
  PVector _pos = new PVector();
  PVector _vel = new PVector();
  color _color;
  float coe1,coe2;
  int time;
  float wrap_x;
  float wrap_y;
  PVector _startpos = new PVector();
  Particle(float xx,float yy,
           float radius,float red,
           float green,float blue,
           float alpha,float scale
           //float rotation,float scale
           )
  {
    //init(radius,rotation,scale,c);
    _pos.x = xx;
    _pos.y = yy;
    _radius = radius;
    _color = color(red,green,blue,alpha);
    _scl = scale;
    _startpos.x = xx;
    _startpos.y = yy;   //起始位置
  //  println(_pos);
    
    if(_pos.x>width/2&&_pos.y<height/2)   //右上角
    {coe1 = -0.5;coe2 =0.5;
     wrap_x = random(0,_pos.x);
     wrap_y = random(_pos.y,height);}
    else if(_pos.x>width/2&&_pos.y>height/2)  //右下角
    {coe1 = -0.5;coe2 =-0.5;
     wrap_x = random(0,_pos.x);
     wrap_y = random(0,_pos.y);}
    else if(_pos.x<width/2&&_pos.y>height/2)   //左下角
    {coe1 = 0.5;coe2 =-0.5;
     wrap_x = random(_pos.x,width);
     wrap_y = random(0,_pos.y);}
    else                                        //左上角
    {coe1 = 0.5;coe2 = 0.5;
     wrap_x = random(_pos.x,width);
     wrap_y = random(_pos.y,height);}
     
     println("_startpos.x"+_startpos.x);
     println("wrap_x"+wrap_x);
    
  }
  
  void getTime(int _time)
  {
    time = _time;
    
  }
  void update()
  {
    //_pos.setMag(_scl);
    //_pos.x+=millis()/20*1;
    //_pos.y+=millis()/20*1;
    _vel.x*=0.98f;
    _vel.y*=0.98f;
    
  }
  
  void draw()
  {
    //_pos.rotate(_rot);
   // float xx,yy;
   float dist_start_posx = abs(_pos.x-_startpos.x);
   float dist_start_posy = abs(_pos.y-_startpos.y);
   
   float dist_end_posx = abs(_pos.x-wrap_x);
   float dist_end_posy = abs(_pos.y-wrap_y);
    //while((dist_start_posx<dist_end_posx)&&
    //       (dist_start_posy<dist_end_posy))
    while(_pos.x>200)
    {
      pushStyle();
    
    fill(_color);
    
    //_pos.x+=coe1*(millis()/100);
    //_pos.y+=coe2*(millis()/100);
    _pos.x+=coe1*(time/5);
    _pos.y+=coe2*(time/5);
    
    //println(millis()/1000);
    noStroke();
    if(_pos.x>=width)
    {
      _pos.x = width;
    }
    else if(_pos.x<=0)
    {
      _pos.x = 0;
    }
    if(_pos.y>=height)
    {
      _pos.y = height;
    }
    ellipse(_pos.x,_pos.y,_radius,_radius);
    
    println("pos"+_pos.x);
    
   // ellipse(_pos.x,_pos.y,_radius,_radius);
    popStyle();
    }
    
   
  }
  
  void make(PVector parentVel)
  {
    PVector newVel = parentVel;
    newVel.rotate(_rot);
    newVel.setMag(_scl);
    _vel = newVel;
  }
  
  PVector getVel()
  {
    return _vel;
  }
  
  void setVel(PVector v)
  {
    _vel = v;
  }
  
   PVector getPos()
  {
    return _pos;
  }
  
  void setPos(PVector p)
  {
    _pos = p;
  }
  
  void init(float radius,
           float rotation,float scale,color c)
  {
    _radius=radius;
    //_pos=pos;
    //_vel=vel;
    _rot=rotation;
    _scl=scale;
    _color = c;
    
  }
}