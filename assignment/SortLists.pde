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
   
   SortLists(String[] data)
   {
       county=data[0];
       y2007=Float.parseFloat(data[1]);
       y2008=Float.parseFloat(data[2]);
       y2009=Float.parseFloat(data[3]);
       y2010=Float.parseFloat(data[4]);
       y2011=Float.parseFloat(data[5]);
       y2012=Float.parseFloat(data[6]);
       y2013=Float.parseFloat(data[7]);
   }
}
