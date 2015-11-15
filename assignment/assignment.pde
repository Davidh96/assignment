void setup()
{
  size(500,500); 
  
  border=width*.1;
  
  loadData();
  sumYears();
  float max=yearMaxSum();
  drawAxis(max);
  drawLineGraph();
}

//This array list is of type SortLists which will be used to hold all my data
ArrayList<SortLists> dlist =new ArrayList<SortLists>();

float border;
int numYears=7;
int numCounties=24;
float maxY;

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

void drawAxis(float max)
{
  
   float windowsp=width-border*2;
   textAlign(CENTER,CENTER);
   text("Number of Deaths in Maryland from 2007-2013",width/2,border*.5);
   
    //y-axis
    line(border,border,border,height-border);
    
    maxY=findMaxWindow(max);
    
    int NumyVal=10;
    float yGap=windowsp/NumyVal;
    
    for(int i=0;i<=NumyVal;i++)
    {
        text((int)map(i,0,NumyVal,0,maxY),border*.5,height-(yGap*i)-border);
        
        //ticks for y-axis
        line(border,height-(yGap*i)-border,border*.75,height-(yGap*i)-border);
    }
    
    
    
    //x-axis
    line(border,height-border,width-border,height-border);
    
    float xGap=windowsp/(yearSums.length-1);
    
    for(int i=0;i<=yearSums.length;i++)
    {
       text((int)map(i,0,yearSums.length-1,2007,2013),(i*xGap)+border,height-(border*.5));
       
       //ticks for x-axis
       line((i*xGap)+border,height-border,(i*xGap)+border,height-(border*.75));
    }
}

float findMaxWindow(float max)
{
   while(max%10!=0)
    {
       max++;
    } 
    
    return max;
}

float yearMaxSum()
{
   
   float max=yearSums[0];
   
   for(int i=1;i<yearSums.length;i++)
   {
     if(max<yearSums[i])
    {
       max=yearSums[i];
    } 
   }
   
   return max;
  
}

//This method draws the line graph which represents the the sum of deaths per year
void drawLineGraph()
{
   
  float windowsp=width-border*2;
  
  for(int i=1;i<yearSums.length;i++)
  {
    float px=map(i-1,0,numYears,0,windowsp+border);
    float py=map(yearSums[i-1],0,maxY,0,windowsp);
    float x=map(i,0,numYears,0,windowsp+border);
    float y=map(yearSums[i],0,maxY,0,windowsp);
    
    line((px)+border,(height-py)-border,(x)+border,(height-y)-border);
  }
  
}

