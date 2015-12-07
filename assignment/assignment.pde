//This program displays the deaths due to alcohol and drugs in Maryland between 2007-2013. The data is displayed using a linegraph, barchart and blockchart.
//David Hunt
void setup()
{
  size(700,700); 
 
  border=width*.1;
  
  //calling my methods
  loadData();
  
  yearSums =new float[numYears];
  tempY=new int[dlist.size()];
  
  sumYears();
  //this array will be used to keep track of where values have gone in an array when they are sorted
  orderArray=new int[dlist.size()];
  
}//end setup()

//This array list is of type SortLists which will be used to hold all my data
ArrayList<SortLists> dlist =new ArrayList<SortLists>();

float border;
int numYears=7;
int numCounties=24;
//maxY is used to round of the top value on the y axis to the nearest 10.
float maxY;
int maxIn;
boolean sort=false;
boolean help;

//this will start the program at the menu
int graph=0;

float [] yearSums;
int[] orderArray;
float[] countySums;
float[] temp;
int[] tempY;

//menuani vars
float[] tempy;
float[] tempW;
float[] tempH;
int[] w;


void draw()
{
  
  background(255,0,0);
  stroke(0);
  fill(255);
  int rectH=40;
  
  //if menu
  if(graph==0)
  {
     menu(); 
  }//end if
  else
  {
    fill(255);
    textSize(12);
    
    fill(0,0,0,100);
    rect(border,border*.25,width-(border*2),rectH);
    fill(255);
    
    //if linegraph
    if(graph==1)
    {
        textAlign(CENTER,CENTER);
        text("Drug & Alcohol related Deaths Each Year in Maryland (2007-2013)",width/2,border*.5);
        //get max for each year
        float max=yearMaxSum(yearSums);
        float avg=lineGraphAvg();
        drawAxis(max);
        drawLineGraph(avg);
        getdets(max,yearSums);
        
    }//end inner if
    
    //if barchart
    if(graph==2)
    {
      textAlign(CENTER,CENTER);
      text("Drug & Alcohol related Deaths per County in Maryland (2007-2013)",width/2,border*.5);
      //get max for each county
      float max=yearMaxSum(countySums);
      drawAxis(max);
      drawBarChart(countySums);
      getdets(max,countySums);
      sortOrder();
      
    }//end inner if
    
    //if blockchart
    if(graph==3)
    {
       float max=yearMaxSum(countySums);
       drawBlockChart(max,countySums);
       textAlign(CENTER,CENTER);
       //had to create the titlebox again because the other boxes drew over it
       fill(0,0,0,100);
       rect(border,border*.25,width-(border*2),rectH);
       fill(255);
       text("Drug & Alcohol related Deaths as % of max County: " + dlist.get(maxIn).county + " (2007-2013)",width/2,border*.5);

       getdets(max,countySums);
    }//end inner if
    
    //This if statement is to make sure that the help message isnt shown on other graphs
    if(graph!=3)
    {
      help=false;
    }//end inner if
   
    //This code creates a button on all graphs so the user can go back to the menu
    fill(255);
    stroke(0);
    int mbuttonW=40;
    int mbuttonH=30;
    rect(width,0,-mbuttonW,mbuttonH);
    fill(0);
    text("Menu",width-(mbuttonW/2),mbuttonH/2);
    
    if(mouseX>width-mbuttonW)
    {
       if(mouseY<mbuttonH)
       {
         
          if(mousePressed)
          {
             graph=0;
          }//end inner if 2
          
       }//end inner if 1
       
    }//end if
    
  }//end else
 
}//end draw

 
//This method controls my menu
void menu()
{
   background(255,0,0);  
   
   //Menu title
   textSize(20);
   textAlign(CENTER,CENTER);
   text("Number of Drug and Alcohol Related Deaths in Maryland, 2007-2013",width/2,border*.5);
   
   //These variables are used for my menu buttons
   float x=border;
   float y=border;
   int menuitems=3;
   int titlePosOffSet=40;
   int subPosOffSet=5;
   float gap=(height-(border*2))/menuitems;
   
   int arraySize=10;
   
   //This loop creates three buttons
   for(int i=0;i<menuitems;i++)
   {
      rect(x,y+(gap*i),width-(border*2),gap); 
   }
   
   //Button titles
   fill(0);
   text("Line Graph",width/2,gap-titlePosOffSet);
   text("Bar Chart",width/2,gap*2-titlePosOffSet);
   text("Block Chart",width/2,gap*3-titlePosOffSet);
   
   //Button subtitles
   textSize(15);
   text("Drug & Alcohol related Deaths Each Year in Maryland (2007-2013)",width/2,gap-subPosOffSet);
   text("Drug & Alcohol related Deaths per County in Maryland (2007-2013)",width/2,(gap*2)-subPosOffSet);
   text("Drug & Alcohol related Deaths as % of max County (2007-2013)",width/2,(gap*3)-subPosOffSet);
    
   //This if statement is used to determine what graph the user has chosen to see
  if(mouseX>border && mouseX<width-x)
  {
      //If they choose the first box then show the line graph
      if(mouseY>border && mouseY<gap+border)
      {
        //call the menuani method for the linegraph animations
        menuani(1,gap);
        
         if(mousePressed)
         {
            graph=1;
         }//end inner if 1
         
         tempy=new float[arraySize];
         
      }//end inner if
      
      //If they choose the second box then show the barchart
      if(mouseY>gap+border && mouseY<gap*2+border)
      {
        //call the menuani method for the barchart animations
        menuani(2,gap);
          
        if(mousePressed)
        {
          graph=2;
          temp=new float[dlist.size()];
          countySums =new float[dlist.size()];
          sumCounty(); 
        }//end inner if
           
         tempW=new float[arraySize];
         tempH=new float[arraySize];  
         w=new int[arraySize+1];
           
      }//end inner if
        
      //If they choose the third box then show the block chart
      if(mouseY>gap*2+border && mouseY<gap*3+border)
      {
        //call the menuani method for the block chart animations
        menuani(3,gap);
        
        if(mousePressed)
         {
            for(int j=0;j<tempY.length;j++)
            {
                tempY[j]=height;
             }//end for
        
            graph=3;
            countySums =new float[dlist.size()];
            sumCounty();
         }//end inner if 1
         
         tempy=new float[arraySize];
         
      }//end inner if
      
      //This initialises the orderArray with values from 0 to the sizeof orderArray. This helps me keep track of the order of arrays when they are sorted
       for(int i=0;i<orderArray.length;i++)
       {
           orderArray[i]=i;
       }//end for
       
  }//end if
  
  //This else reinitialises the variables so that the animations start over again when the mouse moves over them
  else
  {
     tempy=new float[arraySize];
     tempW=new float[arraySize];
     tempH=new float[arraySize];  
     w=new int[arraySize+1];
  }//end else

 }//end menu()
 

//This method controls the animations shown on the menu when a use hovers over a button
 void menuani(int item, float pos)
 {
    
    float windowsp=width-(border*2);
    int arraySize=10;
    float barW=windowsp/arraySize;
    int offSet=20;
    int maxH=50;
    
    //if linegraph button is highlighted
    if(item==1)
    {
      //This loop craetes a simple straight line graph with glowing circles
      for(int i=0;i<=arraySize;i++)
      {
       
        line((i*barW)+border,pos+border-offSet,(i+1*barW)+border,pos+border-offSet);
        
        fill(color(random(0,255),random(0,255),random(0,255)));
        ellipse((i*barW)+border,pos+border-offSet,w[i],w[i]);
        
        //gradually increases the size of the ellipses
        if(w[i]<arraySize)
        {
           w[i]++; 
        }//end inner if
        
      }//end for
      
    }//end if
    
    //if barchart button is highlighted
    if(item==2)
    { 
       //This loop creates a simple barchart that gets exponentially smaller
       for(int i=0;i<arraySize;i++)
       {
         fill(color(random(0,255),random(0,255),random(0,255)));
         rect((i*barW)+border,pos*item+border,barW,-(tempy[i]));
         
         //gradually the bars rise rom the bottom of the button
         if(tempy[i]<maxH/(i+1))
         {
            tempy[i]+=1;
         }//end inner if
         
       }//end for
       
    }//end if
    
    //if block chart button is highlighted
    if(item==3)
    { 
      //this loop creates squares
      for(int i=0;i<arraySize;i++)
      {
        fill(color(random(0,255),random(0,255),random(0,255)));
        rect((i*barW)+border,pos*item+border,tempW[i],-tempH[i]);
        
        //The rects willgradually expand
        if(tempW[i]<barW)
        {
         tempW[i]+=1; 
        }//end inner if
        
        if(tempH[i]<maxH)
        {
         tempH[i]+=1; 
        }//end inner if
        
      }//end for
      
    }//end if
    
}//end menuani()

 
//This method loads the data from the .csv file in the data folder and sorts it by encapsulating using a class called SortLists
void loadData()
{
   //Load the data from my .csv file int the sketch
   String[] lines=loadStrings("drug_alcohol_deaths.csv");
   
   for(int i=1;i<lines.length-1;i++)
   {  
     //Split the string where a "," is found
      String[] data=lines[i].split(",");
      
      
      //Creates a SortList called perCounty. My data will be passed to the method SortLists and sort it for later use and place it in perCounty
      SortLists perCounty= new SortLists(data);
      //For every loop the perCounty is added to my dlist
      dlist.add(perCounty);
      
   }//end for
 
}//end loadData()


//This method sums up all the values for each year. These sums will be used in my line graph
void sumYears()
{
    //This loop adds up all yeras per county to find the total value for Maryland each year
    for(int i=0;i<dlist.size();i++)
    {
      yearSums[0]+=dlist.get(i).y2007;
      yearSums[1]+=dlist.get(i).y2008;
      yearSums[2]+=dlist.get(i).y2009;
      yearSums[3]+=dlist.get(i).y2010;
      yearSums[4]+=dlist.get(i).y2011;
      yearSums[5]+=dlist.get(i).y2012;
      yearSums[6]+=dlist.get(i).y2013;
    }//end for
    
}//end sumYears()


//This method sums up all the values for each county
void sumCounty()
{
   //adds up all the values for each county
   for(int i=0;i<dlist.size();i++)
   {
      countySums[i]=dlist.get(i).total;
   }//end for
   
}//end sumCounty()


//This method is used to identify if user has chosen to sort a list
void sortOrder()
{
  int offSet=20;
  
  //desc box
   rect(0,height,border,-(border*.5)); 
   //asc box
   rect(width,height,-border,-(border*.5)); 
   //reset box
   rect(width/2-offSet,height,offSet,-offSet);
   
   fill(0);
   
   textAlign(CENTER,CENTER);
   text("Desc. Order",border*.5,height-(border*.25));
   
   text("Asc. Order",width-(border*.5),height-(border*.25));
   
   text("R",width/2-(offSet/2),height-(offSet/2));
   
   //if mouse is over desc box
   if(mouseX>0 && mouseX<border)
   {
      if(mouseY>height-(border*5) && mouseY<height)
      {
         //if the desc box is clicked then sort the bars in desc order
         if(mousePressed)
         {
            sort=true;
            boolean desc=true;
            bubbleSort(desc); 
            
         }//end inner if 2
         
      }//end inner if 1
      
   }//end if
   
   //if mouse is over asc box
   if(mouseX>width-border && mouseX<width)
   {
      if(mouseY>height-(border*5) && mouseY<height)
      {
          //if button clicked then sort out the bars in asc order
         if(mousePressed)
         {
            sort=true;
            boolean desc=false;
            bubbleSort(desc); 
         }//end inner if 2
         
      }//end inner if 1
      
   }//end if

}//end sortOrder()


//This method sorts the countySums array
void bubbleSort(boolean desc)
{
  //if we want to sort the array into descending order
  if(desc)
  {
     for(int i=0; i<dlist.size();i++)
     {
       for(int j=0;j<dlist.size();j++)
       {
         if(countySums[i]>countySums[j])
         {
            float temp=countySums[j];
            //I also sort orderArray as so I know where elements from countySums went when ordered.
            int temp2=orderArray[j];
            countySums[j]=countySums[i];
            orderArray[j]=orderArray[i];
            countySums[i]=temp;
            orderArray[i]=temp2;
         }//end inner if
         
       }//end for 1
       
     }//end for
     
  }//end if
  
  //if we want to sort the array into ascending order
  else
  {
    for(int i=0; i<dlist.size();i++)
     {
       for(int j=0;j<dlist.size();j++)
       {
         if(countySums[i]<countySums[j])
         {
            float temp=countySums[i];
            //I also sort orderArray as so I know where elements from countySums went when ordered.
            int temp2=orderArray[i];
            countySums[i]=countySums[j];
            orderArray[i]=orderArray[j];
            countySums[j]=temp;
            orderArray[j]=temp2;
         }//end inner if
         
       }//end inner for
       
     }//end for
     
  }//end else
   
}//end bubbleSort()


//This method draws the axises
void drawAxis(float max)
{
  
   float windowsp=width-border*2;
   textSize(12);
   
    //y-axis
    line(border,border,border,height-border);
    
    //Round the max value to the nearest 10
    maxY=findMaxWindow(max);
    
    //NumyVal is the amount of ticks I want on the y-axis. I chose 10
    int NumyVal=10;
    float yGap=windowsp/NumyVal;
    
    //This loop will adapt to whether the graph being viewed is either the barchart or line graph
    //put in y axis values
    for(int i=0;i<=NumyVal;i++)
    {
        //The y values that are beside the ticks 
        text((int)map(i,0,NumyVal,0,maxY),border*.5,height-(yGap*i)-border);
        
        //ticks for y-axis
        line(border,height-(yGap*i)-border,border*.75,height-(yGap*i)-border);
    }//end for
    
    //x-axis
    line(border,height-border,width-border,height-border);
    
    float xGap=windowsp/(yearSums.length-1);
    
    //if linegraph
    if(graph==1)
    {
      //put in x axis details
      for(int i=0;i<=yearSums.length;i++)
      {
         //The x values that are below the ticks
         text((int)map(i,0,yearSums.length-1,2007,2013),(i*xGap)+border,height-(border*.5));
         
         //ticks for x-axis
         line((i*xGap)+border,height-border,(i*xGap)+border,height-(border*.75));
      }//end for
      
    }//end if
    
}//end drawAxis()


//This method finds what the max value to map the y values of the line graph to. This is used to make the y-axis look nicer.
float findMaxWindow(float max)
{
  //while the max cant be cleanly divided by 10
   while(max%10!=0)
    {
       max++;
    } 
    
    return max;
    
}//end findMaxWindow()


//Finds the max value in the yearSums array.
float yearMaxSum(float [] Sums)
{
   
   float max=Sums[0];
   
   //This loop will go through the sums array to find the max value
   for(int i=1;i<Sums.length;i++)
   {
     //if the current max is smaller then the current value insum[i]
     if(max<Sums[i])
    {
       //record its position so that I can use later to display max county
       maxIn=i;
       //place this new value into sum
       max=Sums[i];
       
    }//end if 
    
   }//end for

   return max;
  
}//end yearMaxSum()

//This methd displays details to the user
void getdets(float max,float[] array)
{
  //windowsp is the actual amount of space I can use for my graph in the x and y directions
  float windowsp=width-(border*2);
  float xGap=windowsp/array.length;
  //space is used so the user can see the details displayed 15 pixels away from the mouse pointer
  int space=15;
  fill(255);
  
  //if the x value of the mouse position is within the graph
  if(mouseX>border && mouseX<width-border)
  {
     //mouseXpos is used to decide which value from yearSums to display
    float mouseXpos=(mouseX-border)/xGap;
    float y=(height-map(array[(int)mouseXpos],0,max,0,windowsp))-border; 
    float x=map((int)mouseXpos,0,array.length,0,windowsp+border);
    
    //if user is viewing the line graph
    if(graph==1)
    {
      text((int)(array[(int)mouseXpos])+" died",border+x,y-space);
      line(x+border,y,mouseX,mouseY);
    }//end inner if
    
    //if the user is viewing the barchart
    if(graph==2)
    {
      if(mouseY>y)
      {
        
        text(dlist.get(orderArray[(int)mouseXpos]).county + ": " + (int)(array[(int)mouseXpos]),mouseX+space,mouseY-space);
      }//end inner if 1
      
    }//end inner if
    
  }//end if
  
  //if mouseY value is down where all the chart details are
  if(mouseY<height && mouseY>height-border)
  {
     
     if(graph==3)
     {
            //mapping the mouseX and mouseY values to the area at the bottom of the graph
            int mX=(int)map(mouseX,0,width,0,dlist.size()/2);
            int mY=(int)map(mouseY,height-border,height,0,2);
            fill(0);
            
            //if first row
            if(mY==0)
            {
               text(dlist.get(orderArray[mX]).county,width/2,(height-border)-space*3);
               //the block has been selected
               dlist.get(mX).select=true;
   
            }//end inner if 1
            
            //if second row
            else
            {
               text(dlist.get(orderArray[(mY*(dlist.size()/2))+mX]).county,width/2,(height-border)-space*3);
               //the block has been selected
               dlist.get((mY*(dlist.size()/2))+mX).select=true;
            }//end else
            
      }//end inner if
      
    }//end if
    
    //if the help button is clicked
    if(help)
    {
       fill(0);
       //This tries to explain to the user what the graph is displaying
       text("This chart shows deaths per county as a % of the max county: " + dlist.get(maxIn).county + "\nThis is to show the variations per county.",width/2,height/2);   
    }//end if
    
}//end getdets()


//This method calculates the average of yearSums.
float lineGraphAvg()
{
   float sum=0;
   
   //sum up all the years
   for(float f: yearSums)
   {
      sum+=f; 
   }//end for
   
   float avg=sum/yearSums.length;
   return(avg);
   
}//end lineGraphAvg()


//GRAPHS

//This method draws the line graph which represents the the sum of deaths per year
void drawLineGraph(float avg)
{
  //windowsp is the actual amount of space I can use for my graph in the x and y directions
  float windowsp=width-(border*2);
  int ballW=10;
  
  //this loop will draw the lines and ellipses
  for(int i=1;i<yearSums.length;i++)
  {
    //the previous x and y are mapped aswell as the x and y values. This will help fit the data into my graph
    float px=map(i-1,0,numYears,0,windowsp+border);
    float py=map(yearSums[i-1],0,maxY,0,windowsp);
    float x=map(i,0,numYears,0,windowsp+border);
    float y=map(yearSums[i],0,maxY,0,windowsp);
    
    //draws the trend between current and previous points
    fill(0);
    line((px)+border,(height-py)-border,x+border,(height-y)-border);
    
    //I draw circles at each point to make it easier to see the various points in the line graph
    fill(255);
    ellipse((px)+border,(height-py)-border,ballW,ballW);
    
    //this if is so that the last ellipse is drawn
    if(i==yearSums.length-1)
    {
       ellipse((x)+border,(height-y)-border,ballW,ballW);
    }//end if

  }//end for  
 
  //draw the average line
  stroke(0,255,0);
  float avgline=map(avg,0,maxY,0,windowsp);
  line(border,(height-avgline)-border,width-border,(height-avgline)-border);
  textAlign(CENTER,CENTER);
  text("Avg:\n" + (int)avg,width-(border*.5),(height-avgline)-border);

}//end drawLineGraph()


//This method draws a barchart to represent the sum of deaths over the seven years per county
void drawBarChart(float[] array)
{
    //windowsp is the actual amount of space I can use for my graph in the x and y directions
    float windowsp=width-(border*2);
    //the width of each bar
    float bWidth=windowsp/dlist.size();
      
   //draw the same amount of bars as the data that im using
   for(int i=0;i<dlist.size();i++)
   {
     //x is the x position of the rect
     float x=(bWidth*i)+border;
     //y is the y position of the rect
     float y=height-border;
     //how tall each bar is calculated and mapped.
     float bHeight=map(array[i],0,maxY,0,windowsp);
     int j=0;
     
     //this bit here will ensure that the colour of a bar corresponds o the colour of its county
     //if the value in array[i] is not the same as the total in dlist then they are not the same county
     while(array[i]!=dlist.get(j).total)
     {
       j++;
     }//end while
     
     if(array[i]==dlist.get(j).total);
     { 
      fill(dlist.get(j).colour);
     }//end if
     
     rect(x,y,bWidth,-temp[i]);
     
     //this part makes the bars smaller or bigger depending on the situation
     //if the current bar height(temp) is smaller than the height it should be it is made bigger!
     if(temp[i]<bHeight)
     {
       //this if statement allows for even numbered heights to be reached quicker
       if(bHeight%2==0)
       {
          temp[i]+=2; 
       }//end inner if
       
       temp[i]+=1;
       
     }//end if
     
     //if the current bar height(temp) is bigger than the height it should be it is made smaller!
     if(temp[i]>bHeight)
     {
       temp[i]-=1;
       
       //this if statement allows for even numbered heights to be reached quicker
        if(bHeight%2==0)
       {
          temp[i]-=2; 
       }//end inner if
       
     }//end if
     
   }//end for 
   
}//end drawBarChart()

//This method draws a Block Chart. It shows the value of each element in sumCounty as a % of the max value.
void drawBlockChart(float max,float[] countySums)
{
   float x=0;
   float y=0;
   float blkW=0;
   float blkH=0;
   float gap=width/(countySums.length/2);
   float yInfo=height-border;
   int multi=0;
   int offSet=30;
   int helpSize=20;
   
   //sort sumCounty so that no blocks overlap one another.
   boolean desc=true;
   bubbleSort(desc);
   
   //This loop creates all the blocks
   for(int i=0;i<countySums.length;i++)
   {
      //the width of each block is mapped to the width
      blkW=map(countySums[i],0,max,0,width);
      blkH=blkW;
     
      fill(dlist.get(i).colour);
      stroke(dlist.get(i).colour);
      
      //if a block has been selected
      if(dlist.get(i).select)
      {
        //set select for all blocks smaller than it, including itself, to true.
        for(int k=dlist.size()-1;k>i;k--)
        {
         dlist.get(k).select=true; 
        }//end inner for
        
        //change all selected boxes to red
         fill(255,0,0);
         stroke(255,0,0);
         
         //sets block select to false
         dlist.get(i).select=false; 
         
      }//end if
      
      rect(x,y,blkW,blkH);

      //creates a new row for the % info
      if(i==countySums.length/2)
      {
         yInfo=height-(border*.5); 
         multi=0;
      }//end if
      
      //Displays the colour block
      stroke(0);
      //changes % rect colour to its corresponding county colour
      fill(dlist.get(i).colour);
      rect((gap*multi)+offSet,yInfo,10,10);
      
      //displyas the %
      fill(0);
      String cSum=nf((countySums[i]/max)*100,0,2);
      text((cSum)+"%",(gap*multi)+offSet,tempY[i]);
     
      //The % rise from the bottom to above their corresponding colour block
      if(tempY[i]>yInfo-(offSet/2))
      {
         tempY[i]--; 
      }//end if
      
      multi++;
   }//end for
   
   //This code is for the help button. The help button will try and explain what the block chart is.
   fill(255);
   rect(width,height/2,-helpSize,helpSize);
   fill(0);
   text("?",width-(helpSize/2),(height/2)+(helpSize/2));
   
   //These if statements check to see if the user has clicked the help button
   if(mouseX>width-helpSize)
   {
     if(mouseY>height/2 && mouseY<(height/2)+helpSize)
     {
        if(mousePressed)
        {
           //toggle help on/off
           help=!help; 
        }//end inner if 1
        
     }//end inner if
     
   }//end if

}//end drawBlockChart()