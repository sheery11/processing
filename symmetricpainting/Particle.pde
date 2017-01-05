class Particle
{
  float _radius,_rot,_scl;
  PVector _pos = new PVector();
  PVector _vel = new PVector();
  color _color;
  float coe1,coe2;
  int time;
  float black_x,black_y;

  float n =5; 
  PVector _startpos = new PVector();
  Particle(float xx,float yy,
           float radius,float red,
           float green,float blue,
           float alpha,float scale,
           float num,
           float coefficient1,
           float coefficient2,
           float rot, 
                    float endxx,float endyy
          ) 
  {
    _pos.x = xx;
    _pos.y = yy;
    _radius = radius;
    _color = color(red,green,blue,alpha);
    _scl = scale;
    _startpos.x = xx;
    _startpos.y = yy;   //起始位置
    n = num;
    coe1 = coefficient1;
    coe2 = coefficient2;
    _rot = rot;
  }
  
  void getTime(int _time)
  {
    time = _time;
    
  }
  
  void getNum(float num)
  {
   // n = num;
    
  }
  void update(int j)
  {
    update = true;
    
    pushStyle();
    //fill(_color);
    fill(brushnew_color.get(j),brushnew_color.get(j+1),
         brushnew_color.get(j+2),brushnew_color.get(j+3));
    noStroke();
    brushend_pos.set(j/2,brushend_pos.get(j/2)+vel.x/80*coe1);
    brushend_pos.set(j/2+1,brushend_pos.get(j/2+1)+vel.y/100*coe2);
    ellipse(brushend_pos.get(j/2),brushend_pos.get(j/2+1),_radius,_radius);
    if(brushend_pos.get(j/2)>=width)
    {
      brushend_pos.set(j/2,0);
      brushend_pos.set(j/2,brushend_pos.get(j/2)-vel.x/100*coe1);
      brushend_pos.set(j/2+1,brushend_pos.get(j/2+1)-vel.y/100*coe2);
    }
    else if(brushend_pos.get(j/2)<=0)
    {
      brushend_pos.set(j/2,width);
      brushend_pos.set(j/2,brushend_pos.get(j/2)-vel.x/100*coe1);
      brushend_pos.set(j/2+1,brushend_pos.get(j/2+1)-vel.y/100*coe2);
    }
    else if(brushend_pos.get(j/2+1)>height)
    {
      brushend_pos.set(j/2+1,0);
      brushend_pos.set(j/2,brushend_pos.get(j/2)-vel.x/100*coe1);
      brushend_pos.set(j/2+1,brushend_pos.get(j/2+1)-vel.y/100*coe2);
    }
    else if(brushend_pos.get(j/2+1)<0)
    {
      brushend_pos.set(j/2+1,height);
      brushend_pos.set(j/2,brushend_pos.get(j/2)-vel.x/100*coe1);
      brushend_pos.set(j/2+1,brushend_pos.get(j/2+1)-vel.y/100*coe2);
    }
    popStyle();
   // println("endbrush1.x"+endbrush1.x);
    
  }
  
  void draw()
  {
    pushStyle();
    if(!end)
    {
    
    fill(_color);
    _pos.x+=coe1*(time*n)/2;
    _pos.y+=coe2*(time*n);
    noStroke();
    
    ellipse(_pos.x,_pos.y,_radius,_radius);  
    }
    println("end_x"+end_x); //end的坐标是对的
   
   popStyle();
  
  }
  

  PVector getVel()
  {
    return _vel;
  }
  
  void setVel(PVector v)
  {
    _vel = v;
    _vel.x*=0.98f*_scl;
    _vel.y*=0.98f*_scl; 
    _vel.rotate(_rot);
    println(_vel.x);
  }
  
   PVector getPos()
  { 
    return _pos;
  }
  
  void setPos(PVector p)
  {
    _pos = p;
  }
}