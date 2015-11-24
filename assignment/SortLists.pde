class SortLists
{
   String county;
 
   float y2007;
   float y2008;
   float y2009;
   float y2010;
   float y2011;
   float y2012;
   float y2013;
   
   color colour;
   
   SortLists(String[] data)
   {
       if(data[0].length()>4)
       {
          int i=data[0].indexOf(" ");
          data[0]=data[0].substring(0,3)+"." + data[0].substring(i+1,i+2); 
       }
       county=data[0];
       
   
    
       y2007=Float.parseFloat(data[1]);
       y2008=Float.parseFloat(data[2]);
       y2009=Float.parseFloat(data[3]);
       y2010=Float.parseFloat(data[4]);
       y2011=Float.parseFloat(data[5]);
       y2012=Float.parseFloat(data[6]);
       y2013=Float.parseFloat(data[7]);
       
       colour=color(0,random(0, 255), random(0, 255));
       
   }
 
}
