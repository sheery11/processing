class Timer {
int savedTime; // 计时器何时开始
int passedTime;
Timer() {

}

void start() {
// 当计时器开启，它将当前时间以毫秒存储下来
savedTime = millis();

}


int nowTime()
{
  passedTime = millis()- savedTime;
 // println(passedTime/1000);
 //println("pass"+passedTime/100);
 if(passedTime/120>=15)
 {//
   //passedTime = 15*120;
   end = true;
 }//
 else end = false;
// print(end);
 
//println(passedTime/120);
 return passedTime/120;
 
}
}