import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import math

def organize_data(data, engines, mappings):

    average_data = pd.DataFrame(columns = ['engine', 'mapping', 'memory_max'])
    for i in range(0, len(data)-2):
        if (data.iloc[i]['engine'] == data.iloc[i+1]['engine'] and data.iloc[i]['engine'] == data.iloc[i+2]['engine']):
            if (data.iloc[i]['mapping'] == data.iloc[i+1]['mapping'] and data.iloc[i]['mapping'] == data.iloc[i+2]['mapping']):
                if data.iloc[i]['memory_max'] == "OutOfMemory" or data.iloc[i+1]['memory_max'] == "OutOfMemory" or data.iloc[i+2]['memory_max'] == "OutOfMemory":
                    out_of_memory = []
                    for j in range (0,3):
                        out_of_memory.append(float(data.iloc[i+j]['memory_max'].replace("OutOfMemory", "128000000")))

                    av_memory_max = ((out_of_memory[0] + out_of_memory[1] + out_of_memory[2])/3)
                    average_data.loc[len(average_data)] = [data.iloc[i]['engine'], data.iloc[i]['mapping'], math.log10(av_memory_max)]
                else:
                    av_memory_max = ((float(data.iloc[i]['memory_max']) + float(data.iloc[i+1]['memory_max']) + float(data.iloc[i+2]['memory_max']))/3)
                    average_data.loc[len(average_data)] = [data.iloc[i]['engine'], data.iloc[i]['mapping'], math.log10(av_memory_max)]    
            else:
                next
        else:
            next
    
    ordered_data = pd.DataFrame(columns = mappings, index=engines)
    for i in range(0, len(average_data)):
        for j in range(0, len(ordered_data.index)):
            for k in range(0,len(ordered_data.columns)):
                if str(average_data.iloc[i]['engine']).lower() == ordered_data.index[j] and str(average_data.iloc[i]['mapping']).lower() == ordered_data.columns[k]:
                    ordered_data.iloc[j,k] = average_data.iloc[i]['memory_max']
                    break
    #return(ordered_data)
    return(ordered_data.replace(np.nan, 0))


def plot(data, scale):

    #engines = ['carml', 'chimera', 'db2triples', 'ontop', 'morph-rdb', 'r2rml-f', 'rmlmapper', 'rmlstreamer', 'rocketrml', 'sdm-rdfizer']
    engines = ['DB2Triples', 'Ontop', 'Morph-RDB', 'R2RML-F', 'RocketRML', 'SDM-RDFizer', 'Chimera', 'RMLMapper', 'CARML']
    mappings = ['gtfs-rdb', 'gtfs-csv', 'gtfs-xml', 'gtfs-json', 'gtfs-custom']
    ordered_data = organize_data(data, [x.lower() for x in engines], mappings)

    #print(ordered_data)

    barWidth = 0.11

    r1 = np.arange(len(ordered_data.columns))
    r2 = [x + barWidth for x in r1]
    r3 = [x + barWidth * 2 for x in r1]
    r4 = [x + barWidth * 3 for x in r1]
    r5 = [x + barWidth * 4 for x in r1]
    r6 = [x + barWidth * 5 for x in r1]
    r7 = [x + barWidth * 6 for x in r1]
    r8 = [x + barWidth * 7 for x in r1]
    r9 = [x + barWidth * 8 for x in r1]
    #r10 = [x + barWidth * 9 for x in r1]

    plt.bar(r1, ordered_data.values.tolist()[0], width=barWidth, color='#F2BABA',#FCD29F
                label='DB2Triples')
    plt.bar(r2, ordered_data.values.tolist()[1], width=barWidth, color='#A46593',#FCAB64
                label='Ontop')
    plt.bar(r3, ordered_data.values.tolist()[2], width=barWidth, color='#2862CC',#B1ACAA
                label='Morph-RDB')
    plt.bar(r4, ordered_data.values.tolist()[3], width=barWidth, color='#90AFE9',#F2BABA
                label='R2RML-F')
    plt.bar(r5, ordered_data.values.tolist()[4], width=barWidth, color='#A1FCDF',#90AFE9
                label='RocketRML')
    plt.bar(r6, ordered_data.values.tolist()[5], width=barWidth, color='#FCD29F',#2862CC
                label='SDM-RDFizer')
    plt.bar(r7, ordered_data.values.tolist()[6], width=barWidth, color='#FCAB64',#73D4B7
                label='Chimera')
    plt.bar(r8, ordered_data.values.tolist()[7], width=barWidth, color='#B1ACAA',#A46593
                label='RMLMapper')
    plt.bar(r9, ordered_data.values.tolist()[8], width=barWidth, color='#73D4B7',#A46593
                label='CARML')

    plt.xticks([r + barWidth*4.5  for r in range(len(r1))], mappings, fontsize=12)

    plt.yticks(np.arange(0, 9), ('0.0', '1.0', '2.0', '3.0', '4.0', '5.0', '6.0', '7.0', 'OutOfMemory'), fontsize=12)
    plt.ylim(top= math.log10(100000000))
    plt.ylabel("Maximum memory (log$_{10}$(kB))", fontsize=12) #(log$_{10}$(kB))
    plt.xlabel("Mapping", fontsize=12)
 
    plt.legend(engines, loc='lower center', prop={'size': 10}, ncol=4, bbox_to_anchor=(0.4, -0.34))
        
    plt.savefig("./figures/memory_" + scale + ".pdf", bbox_inches='tight', dpi=700)

    plt.clf()

    print("Finished: 'figures/memory_" + scale +"'")

def handler():

    scales = ['GTFS-1', 'GTFS-10', 'GTFS-100']
    for scale in scales:
        plot(pd.read_csv("./data/Results - Time - " + scale + ".csv"), scale)

    # Test
    #plot(pd.read_csv("./data/Results - Time - GTFS-1.csv"), 'gtfs-1')



if __name__ == "__main__":
    handler()
