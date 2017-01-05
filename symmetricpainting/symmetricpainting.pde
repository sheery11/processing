import controlP5.*;
import de.bezier.guido.*;
ControlP5 cp5;

MyColorPicker cp;
Timer timer;
ControlWindow controlWindow;
Particle mover;
Particle endbrush;
float[] brush_pos;
FloatList  brushnew_pos;   //存储起始坐标，半径
FloatList brushnew_color;    //存储颜色
FloatList brushend_pos;
FloatList coe;   //存储每一个画刷的系数

boolean AddBrush = false;
boolean randomBrush = true;

boolean inside1 = false;
boolean inside2 = false;

boolean end = false;
boolean update = false;
float x,y;
int press_time = 0;

int starttime = 0;
int savedTime;
int _time;
float _num; 
float end_x;
float end_y;
PVector vel = new PVector();
int num_brush = 0; //记录画刷数
float rot;

PVector end_ = new PVector();   //最后的点
void setup() {
  size(600, 500);
  frameRate(30);
  timer = new Timer();
  timer.start();
  //noStroke();
  brush_pos = new float[2];   //黑色，记录横纵坐标
  brushnew_pos = new FloatList();  //彩色位置
  brushnew_color = new FloatList();    //记录颜色
  brushend_pos = new FloatList();  //记录最后到达的坐标
  coe = new FloatList();  //系数
  
  brush_pos[0]=(width/2);  //下标0
  brush_pos[1]=(height/2);  //是最初的
 // println(brush);
  smooth();
  background(255);
  x =width/2;
  y =height/2;
  
  for(int i =0;i<60;i++)
   {
     brushend_pos.set(i,0);
   
     
   }
  gui();

}

void gui()
{
  Interactive.make(this);
  new CheckBox( "Checkbox #", 12, 14 );
  
  cp5 = new ControlP5(this);
  cp = new MyColorPicker(cp5, "color");
   
  cp5.addSlider("DragSpeed")   //速度
     .setPosition(3,3)
     .setSize(170,15)
     .setValue(5.0)
     .setRange(0.5,20)
     .setColorForeground(color(120))
     .setColorActive(color(128)) 
     .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
     ;
     
  cp5.addBang("addBrush")
     .setPosition(16,20)
     .setSize(157,14)
     .setColorForeground(color(16,78,139))
     .setColorActive(color(0)) 
     .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
     ;
     
  
     
  cp5.addBang("RandomBrushProps")
     .setPosition(16,36)
     .setSize(157,14)
     .setColorForeground(color(16,78,139))
     .setColorActive(color(0)) 
     .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
     ;
     
  Group g1 = cp5.addGroup("color")
                .setPosition(3,62)
                .setBackgroundHeight(70)
                .setWidth(170)
                .activateEvent(true)
                .setBackgroundColor(color(255,50))
                   ;  
   
   cp.setPosition(0, 3)
     .setColorValue(color(0, 0, 0, 255))
     .setGroup(g1)
     ;
 
   cp5.addSlider("Rotation")   //rotation
      .setPosition(3,127)
      .setSize(170,15)
      .setValue(0.0)
      .setRange(-180,180)
      .setColorForeground(color(120))
      .setColorActive(color(128))
      //.setGroup(g1)
      .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
      ;     
     
   cp5.addSlider("Scale")   //scale
      .setPosition(3,145)
      .setSize(170,15)
      .setValue(1.0)
      .setRange(-5,5)
      .setColorForeground(color(120))
      .setColorActive(color(128)) 
      //.setGroup(g1)
      .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
      ;  
     
   cp5.addSlider("Radius")   //radius
      .setPosition(3,163)
      .setSize(170,15)
      .setValue(15.0)
      .setRange(5,25)
      .setColorForeground(color(120))
      .setColorActive(color(128)) 
      //.setGroup(g1)
      .getCaptionLabel().align(ControlP5.RIGHT, ControlP5.CENTER)
      ;  
}

class MyColorPicker extends ColorPicker {
  MyColorPicker(ControlP5 cp5, String theName) {
    super(cp5, cp5.getTab("default"), theName, 0, 0, 170, 11);
  }
}

  public class CheckBox
{

    float  width, height;
   
    CheckBox ( String l, float ww, float hh )
    {
        width = ww; height = hh;
        Interactive.add( this );
    }
    
    void draw ()
    {
       
        color(16,78,139);
       // rect( x, y, width, height );
        line(3,20,3+width,20);
        line(3+width,20,3+width,20+height);
        line(3+width,20+height,3,20+height);
        line(3,20+height,3,20);
        
        line(3,36,3+width,36);
        line(3+width,36,3+width,36+height);
        line(3+width,36+height,3,36+height);
        line(3,36+height,3,36);

    }

}


void mousePressed()
     {
       if(mouseX>3&&mouseX<3+13&&mouseY<20+13&&mouseY>20)
       {
         AddBrush = !AddBrush;
       
       }
       
       
       if(mouseX>3&&mouseX<3+13&&mouseY<36+13&&mouseY>36)
       {
         randomBrush = !randomBrush;
       
       }
        
       if(AddBrush)
       {
          color(16,78,139);
          pushStyle();
          strokeWeight(1);
          line(4,21,4+11,21+12);
          line(4+11,21,3,21+12);
          popStyle();
          _num = random(3,12);  //随机生成倍数关系
         
       }
       else if(!AddBrush)
       {
          color(255);
          rect(3,20,14,14);
        
       }
       
       if(randomBrush)
       {
          color(16,78,139);
          pushStyle();
          strokeWeight(1);
          line(3,36,3+13,36+13);
          line(3+13,36,3,36+13);
          popStyle();
       }
       else if(!randomBrush)
       {
          color(255);
         
          rect(3,36,13,18);
       
       }
       
       if(AddBrush)   //如果选中增加画刷
       {
         float radius = cp5.getController("Radius").getValue();       
         float scl = cp5.getController("Scale").getValue();
         color c = cp.getColorValue();
         rot = cp5.getController("Rotation").getValue();
         if(randomBrush)
         {
           //println("yes");
            radius = random(10,25);
            rot = random(-180,180);
            scl = random(-2,2);  //长度？
            c = color(random(255),random(255),
                     random(255),random(75,150));
           // println(alpha(c));
         }
           
            pushStyle();
            fill(c);   //随机
            noStroke();
            smooth();
            if(mouseX>170||mouseY>180)
            {     
              smooth();
              num_brush++;
              ellipse(mouseX,mouseY,radius,radius);        
              float randomend_x = random(0,width);
              float randomend_y = random(0,height);//随机生成到达的地方
              float k1 = (randomend_y-mouseY)/120;
              float k2 = (randomend_x-mouseX)/120;
              brushnew_pos.append(mouseX);
              brushnew_pos.append(mouseY);
              brushnew_pos.append(radius);
              brushnew_pos.append(scl);
              
              brushnew_color.append(red(c));
              brushnew_color.append(green(c));
              brushnew_color.append(blue(c));
              brushnew_color.append(alpha(c));
              
              coe.append(k1);
              coe.append(k2);
              
              //println(brushnew_pos);
              println("k1"+" "+k1);
              println("k2"+" "+k2);
             
            }

            popStyle();
  
        }
        
     }


  void mouseReleased()
  {
    press_time = 0;
    //println(press_time);
    
    if(!AddBrush&&brushnew_pos.size()!=0)
    {
      //starttime ++;
      timer.start();     //计时开始
      
      if(end)
      {
     if(!update)
     {
       for(int i =0;i<brushnew_pos.size();i+=4)
   {
     brushend_pos.set(i/2,brushnew_pos.get(i)+coe.get(i/2)*15*_num/2);
     brushend_pos.set(i/2+1,brushnew_pos.get(i+1)+coe.get(i/2+1)*15*_num);
     
   }
     }
   
  // println(brushend_pos);
      }
      
    }
    println(brush_pos[0]);
  }


     void draw() {    //判断是否mousepressed不能写在draw函数中
 //background(255);   //这里如果background了，就不能打叉了
 
       _time = timer.nowTime();
       
       pushStyle();
       noStroke();
       popStyle();
       stroke(0);
   
       pushStyle();
       fill(0);
       ellipse(width/2,height/2,15,15);
       popStyle();
   
       if(randomBrush)
       {
        color(16,78,139);
        line(3,36,3+13,36+13);
        line(3+13,36,3,36+13);
       }
  
  
    if (mousePressed&&!AddBrush)    //两种情况
    {  
      press_time++;
   
      if(press_time==1)
        {
         x = mouseX;
         y = mouseY;
        }
     
       float dragspd = cp5.getController("DragSpeed").getValue();
    
       x+=(mouseX - x)*dragspd/100;
       y+=(mouseY - y)*dragspd/100;  
       
       brush_pos[0]=x;
       brush_pos[1]=y;  //获得了最新的黑色点的坐标
       PVector offset = new PVector();
       offset.x = mouseX - brush_pos[0];
       offset.y = mouseY - brush_pos[1];
      
       vel.x = offset.x*dragspd;
       vel.y = offset.y*dragspd;
       //println("vel.x"+vel.x);
       
       
       pushStyle();
       fill(0);
  
     if(mouseX>30||mouseY>50)
     {
       
       ellipse(x,y,15,15);
      
       if(brushnew_pos.size()!=0)  //按压
       {
         
        for(int i =0;i<brushnew_pos.size();i+=4)
      {

        mover.setVel(vel);
        mover.update(i);
       }  
       }       
     }
     popStyle();
   
     }
    else if(press_time==0&&!AddBrush&&brushnew_pos.size()!=0)  //释放画刷
    {   
      
       brush_pos[0]=x;
       brush_pos[1]=y;
       for(int i =0;i<brushnew_pos.size();i+=4)
      {
        rot = cp5.getController("Rotation").getValue();
       
          mover = new Particle(brushnew_pos.get(i),
                             brushnew_pos.get(i+1),
                             brushnew_pos.get(i+2),
                         
                             brushnew_color.get(i),
                             brushnew_color.get(i+1),
                             brushnew_color.get(i+2),
                             brushnew_color.get(i+3),
                             brushnew_pos.get(i+3),  //scl
                             _num,
                             coe.get(i/2),
                             coe.get(i/2+1),
                             rot,
                             brushend_pos.get(i/2),
                             brushend_pos.get(i/2+1)
                             );
        
     
        mover.getTime(_time);
        mover.draw(); 
        //mover.getPos(); 
       }  
       
    }
}