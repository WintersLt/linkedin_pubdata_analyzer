#!/usr/bin/env python

import urllib2
import simplejson
 
BASE_URL = "https://www.googleapis.com/customsearch/v1?key=<YOUR_API_KEY_HERE>&cx=001998005080899164904:zhuvw5wn6hs&q=ncsu+computer+science+india"
 
 
def __get_all_hcards_from_query(index=0):
    url = BASE_URL
    if index == 2:
        return ""
    if index != 0:
        url = url + '&start=%d' % (index)
    resp = urllib2.urlopen(url).read()
    json = simplejson.loads(resp)
    if json.has_key('error'):
        print "Stopping at %s due to Error!" % (url)
        print json.du
    else:
        filename = './results/res%d' % (index)
        f1 = open(filename, 'w+')
        f1.write(resp)
        if json['queries'].has_key('nextPage'):
            return __get_all_hcards_from_query(json['queries']['nextPage'][0]['startIndex'])
    return ""
 
if __name__ == '__main__':
    __get_all_hcards_from_query()
