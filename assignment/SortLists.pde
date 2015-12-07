//this class is used to sort my dataset
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
   
   //this array list will keep all my years
   ArrayList<Float> years;
   float total;
   color colour;
   
   //this select boolean is used fo when a section of my Block Chart has been selected
   boolean select=false;
   
   SortLists(String[] data)
   {
       //I alter the county srings in order to make it easier to read
       int i=data[0].indexOf(" ");
       if(i>3)
       {
         data[0]=data[0].substring(0,3)+"."+data[0].substring(i+1);
       }
       county=data[0];
       
       years=new ArrayList<Float>();

       y2007=Float.parseFloat(data[1]);
       y2008=Float.parseFloat(data[2]);
       y2009=Float.parseFloat(data[3]);
       y2010=Float.parseFloat(data[4]);
       y2011=Float.parseFloat(data[5]);
       y2012=Float.parseFloat(data[6]);
       y2013=Float.parseFloat(data[7]);
       
       years.add(y2007);
       years.add(y2008);
       years.add(y2009);
       years.add(y2010);
       years.add(y2011);
       years.add(y2012);
       years.add(y2013);
       
       sumUpCounty(years);
       
       //this colour is used for my bar chart and block chart
       colour=color(random(100,255),random(100, 255), random(100, 255));
       
   }
   
   //This method is used to sum up all the years of each county
   void sumUpCounty(ArrayList<Float> years)
   {
       total=0;
       
       //this loop adds all the years together for each county to get the total for each county
       for(int i=0;i<years.size();i++)
       {
         total+=years.get(i);
       }
   }
   
 
}