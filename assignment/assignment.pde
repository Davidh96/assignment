void setup()
{
  size(500,500); 
  
  border=width*.1;
  
  loadData();
  sumYears();
  drawAxis();
  drawLineGraph();
}

//This array list is of type SortLists which will be used to hold all my data
ArrayList<SortLists> dlist =new ArrayList<SortLists>();

float border;
int numYears=7;
int numCounties=24;

float [] yearSums =new float[numYears];
float[] countySums =new float[numCounties];


//This method loads the data from the .csv file in the data folder and sorts it by encapsulating using a class called SortLists
void loadData()
{
   //Load the data from my .csv file int the sketch
   String[] lines=loadStrings("drug_alcohol_deaths.csv");
   
   for(int i=1;i<lines.length-1;i++)
   {  
     //Split the string where a "," is found
      String[] data=lines[i].split(",");
      
      //sumCounty(data);
      
      //Creates a SortList called perCounty. My data will be passed to the method SortLists and sort it for later use and place it in perCounty
      SortLists perCounty= new SortLists(data);
      //For every loop the perCounty is added to my dlist
      dlist.add(perCounty); 
   }
 
}

//This method sums up all the values for each year. These sums will be used in my line graph
void sumYears()
{
    for(int i=0;i<dlist.size();i++)
    {
      yearSums[0]+=dlist.get(i).y2007;
      yearSums[1]+=dlist.get(i).y2008;
      yearSums[2]+=dlist.get(i).y2009;
      yearSums[3]+=dlist.get(i).y2010;
      yearSums[4]+=dlist.get(i).y2011;
      yearSums[5]+=dlist.get(i).y2012;
      yearSums[6]+=dlist.get(i).y2013;
    }
    
}

//This method sums up all the values for each county
void sumCounty()
{
   
}

void drawAxis()
{
    //y-axis
    line(border,border,border,height-border);
    
    //x-axis
    line(border,height-border,width-border,height-border);
}

//This method draws the line graph which represents the the sum of deaths per year
void drawLineGraph()
{
   
  float windowsp=width-border*2;
  
  for(int i=1;i<yearSums.length;i++)
  {
    float px=map(i-1,0,numYears,0,windowsp+border);
    float py=map(yearSums[i-1],0,1000,0,windowsp);
    float x=map(i,0,numYears,0,windowsp+border);
    float y=map(yearSums[i],0,1000,0,windowsp);
    
    line((px)+border,(height-py)-border,(x)+border,(height-y)-border);
  }
  
}

