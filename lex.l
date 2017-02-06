%{
#include <stdio.h>
#include "y.tab.h"
extern FILE *out;
%}
%%

\<h3[ \r]style=\"color:#ff0;[ \r]font-weight:[ \r]bold;\"\>.*\<\/h3\> {
																		char *data = strdup(yytext);
																		char processed_data[500];
																		int index1= (int)(strchr(data,'>')-data)+1;
																		int index2 = (int)(strstr(data,"</h3>")-data);
																		memcpy( processed_data, &data[index1], index2-index1 );
																		processed_data[index2-index1]='\0';
																		yylval.str = strdup(processed_data);
																		return NAME;}

\<i[ \r]class=\"fa[ \r]fa-phone\"\>\<\/i\>[ \t\n]*&nbsp;.*[ \t\n]*\<\/li\> {
																			char *data = strdup(yytext);
																			char processed_phone[500];
																			int index1= (int)(strstr(data,"&nbsp;")-data)+6;
																			memcpy( processed_phone, &data[index1], 15 );
																			processed_phone[15]='\0';
																			yylval.str = strdup(processed_phone);
																			return PHONE;
																			}

\<i[ \r]class=\"fa[ \r]fa-envelope\"\>\<\/i\>[ \t\n]*&nbsp;.*[ \t\n]*\<\/li\>  {
																				char *data = strdup(yytext);
																				char processed_data[500];
																				int index1= (int)(strstr(data,"&nbsp;")-data)+6;
																				int index2 = (int)(strstr(data,".in")-data)+3;
																				memcpy( processed_data, &data[index1], index2-index1 );
																				processed_data[index2-index1]='\0';
																				yylval.str = strdup(processed_data);
																				return EMAIL;
																				}

\<div[ \r]*id=\"collapseOne\"[ \r]class=\"accordion-body[ \r]collapse[ \r]in\"[ \r]aria-expanded=\"true\"\>[ \t\n]*\<div[ \r]class=\"accordion-inner\"\>[ \t\n]*\<ul\>[ \t\n]*\<li\>.*\<\/li\>  {
																																																char *data = strdup(yytext);
																																																char processed_data[500];
																																																int index1= (int)(strstr(data,"<li>")-data)+4;
																																																int index2 = (int)(strstr(data,"</li>")-data);
																																																memcpy( processed_data, &data[index1], index2-index1 );
																																																processed_data[index2-index1]='\0';
																																																yylval.str = strdup(processed_data);
																																																return RESP;}
\<p[ \r]style=\"font-weight:[ \r]bold;\"\>[ \t\n]*\<span\>.*\<\/span\> {
																		char *data = strdup(yytext);
																		char processed_data[500];
																		int index1= (int)(strstr(data,"<span>")-data)+6;
																		int index2 = (int)(strstr(data,"</span>")-data);
																		memcpy( processed_data, &data[index1], index2-index1 );
																		processed_data[index2-index1]='\0';
																		yylval.str = strdup(processed_data);
																		return DESG;
																		} 

\<a[ \r]target=\"_blank\"[ \r]href=\".*\"\>[ \t\n]*Website 				{
																		char *data = strdup(yytext);
																		char processed_data[500];
																		int index1= (int)(strstr(data,"htt")-data);
																		int index2 = (int)(strstr(data,"\">")-data);
																		if(!strstr(data,"htt") || !strstr(data,"\">")){
																			char *error = "Not found";
																			yylval.str = strdup(error);
																			return WEB;
																		}
																		else{
																		memcpy( processed_data, &data[index1], index2-index1 );
																		processed_data[index2-index1]='\0';
																		yylval.str = strdup(processed_data);
																		return WEB;
																		}
	
																		}  

\<p[ \r]class=\"text-justify\"\>[ \t\r\n]*\<span[ \r]class=\"glyphicon[ \r]glyphicon-circle-arrow-right\"\>\<\/span\>([ \r\t\n]|.)*resp-tab2  {
																																					char *data = strdup(yytext);
																																					char processed_data[5000];
																																					int index1= (int)(strstr(data,"</span>")-data)+9;
																																					int index2 = (int)(strstr(data,"</div>")-data);
																																					memcpy( processed_data, &data[index1], index2-index1 );
																																					processed_data[index2-index1]='\0';
																																					yylval.str = strdup(processed_data);
																																					printf("%s\n",yylval.str);
																																					fprintf(out, "RESEARCH\n%s\nPUBLICATIONS\n",yylval.str);
																																					fflush(NULL); 
																																					} 

\<div[ \r]style=\"height:[ \r]0px;\"[ \r]id=\"collapseseven\"[ \r]class=\"accordion-body[ \r]collapse\"\>[ \r\t\n]*\<div[ \r]class=\"accordion-inner\"\>[ \r\t\n]*\<ul\>[ \r\t\n]*(\<li\>.*\<\/li\>|[ \t\n\r])*\<\/ul\>  {
																																						char *data = strdup(yytext);
																																						char processed_data[500];
																																						int index1= (int)(strstr(data,"<li>")-data)+4;
																																						int index2 = (int)(strstr(data,"</ul>")-data);
																																						memcpy( processed_data, &data[index1], index2-index1 );
																																						processed_data[index2-index1]='\0';
																																						yylval.str = strdup(processed_data);
																																						printf("%s\n",yylval.str);
																																						fprintf(out, "AWARDS\n");
																																						return AWARD;
																																						} 


\<div[ \r]class=\"tab-pane\"[ \r]id=\"resp-tab2\"\>			{fprintf(out, "PUBLICATIONS\n");} 
\<div[ \r]class=\"tab-pane\"[ \r]id=\"resp-tab3\"\> 		{fprintf(out,"PROJECTS\n"); }
\<div[ \r]class=\"tab-pane\"[ \r]id=\"resp-tab4\"\> 		{fprintf(out,"STUDENTS\n");}
\<b\>Ph\.D\.[ \r]\<\/b\>Students\<\/u\>						{fprintf(out,"PhD STUDENTS\n");}
\<b\>MS[ \r]\<\/b\>Students\<\/u\>							{fprintf(out,"MS STUDENTS\n");}
\<p\>\<span[ \r]*class=\"glyphicon[ \r]*glyphicon\-circle\-arrow\-right\"\>\<\/span\>  {
																							return PBEGIN;
																						}
\([0-9]{4}\)[ \r\t\n]*\<\/p\>	 {
				//printf("%s\n", yytext);
				char year[7];
				strncpy(year, yytext+1, 4); 
				year[4]='\0';
				fprintf(out, "%s\n", year);
				return PEND;
			}																		     		
\<\/p\>	 {
				return PEND; 
			}
\<[^\>]*\> 				/*Ignore all tags not handled so far*/


[\n]+                      		//{fprintf(out,"\\n matched");}/* ignore end of line */;
[ \t]{2,}                  			//{fprintf(out,"\\t matched");}/* ignore whitespace */;
.                       			{ yylval.str = strdup(yytext); return CHR; }

%%
