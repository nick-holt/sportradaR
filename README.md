README
================

This is a working draft of an R wrapper for the sportradar.com API. Hopefully this will be a useful tool for anyone looking to pull historic data for a variety of sports (Sport Radar has APIs for 49 sports).

Basic Documentation
-------------------

As of now, I'm developing functionality for the Golf API. If you are interested in another sport, feel free to port these functions and submit a pull request.

### Golf Functionality Basics

First, you'll need to set your API key and access level.

``` r
golf_key <- "<insert your API key>"
access_level <- "t" # specify t for trial access; specify p for production-level access
```

The following will retrieve schedule information about all PGA tournaments for a given year.

``` r
# get schedule for 2017, glimpse data
pga_schedule_2017 <- getGolfTournamentSchedule(year = "2017")

kable(head(pga_schedule_2017), format = "markdown")
```

<table style="width:100%;">
<colgroup>
<col width="12%" />
<col width="12%" />
<col width="3%" />
<col width="2%" />
<col width="4%" />
<col width="3%" />
<col width="2%" />
<col width="3%" />
<col width="3%" />
<col width="6%" />
<col width="12%" />
<col width="12%" />
<col width="5%" />
<col width="4%" />
<col width="4%" />
<col width="4%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">id</th>
<th align="left">name</th>
<th align="left">event_type</th>
<th align="right">purse</th>
<th align="right">winning_share</th>
<th align="left">currency</th>
<th align="right">points</th>
<th align="left">start_date</th>
<th align="left">end_date</th>
<th align="left">course_timezone</th>
<th align="left">venue_id</th>
<th align="left">venue_name</th>
<th align="left">venue_city</th>
<th align="left">venue_state</th>
<th align="left">venue_zipcode</th>
<th align="left">venue_country</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">2febfbda-3fd8-44a5-872e-fc0447bf792b</td>
<td align="left">Safeway Open</td>
<td align="left">stroke</td>
<td align="right">6000000</td>
<td align="right">1080000</td>
<td align="left">USD</td>
<td align="right">500</td>
<td align="left">2016-10-13</td>
<td align="left">2016-10-16</td>
<td align="left">US/Pacific</td>
<td align="left">117a15a3-be47-4216-9bbe-04a477a5a15c</td>
<td align="left">Silverado Resort and Spa (North Course)</td>
<td align="left">Napa</td>
<td align="left">CA</td>
<td align="left">94558</td>
<td align="left">USA</td>
</tr>
<tr class="even">
<td align="left">4420cd8d-22af-4966-8e2f-3961e6e0a556</td>
<td align="left">CIMB Classic</td>
<td align="left">stroke</td>
<td align="right">7000000</td>
<td align="right">1260000</td>
<td align="left">USD</td>
<td align="right">500</td>
<td align="left">2016-10-19</td>
<td align="left">2016-10-23</td>
<td align="left">Asia/Kuala_Lumpur</td>
<td align="left">ea7f011b-163f-49cc-909e-3b46a53c0d47</td>
<td align="left">TPC Kuala Lumpur</td>
<td align="left">Kuala Lumpur</td>
<td align="left">NA</td>
<td align="left">NA</td>
<td align="left">MYS</td>
</tr>
<tr class="odd">
<td align="left">db5262ae-d7bb-4b38-9ed6-c4b5bb06208e</td>
<td align="left">World Golf Championships-HSBC Champions</td>
<td align="left">stroke</td>
<td align="right">9500000</td>
<td align="right">1620000</td>
<td align="left">USD</td>
<td align="right">550</td>
<td align="left">2016-10-26</td>
<td align="left">2016-10-30</td>
<td align="left">Asia/Shanghai</td>
<td align="left">0b919d8b-b97a-4549-a021-95dff524ea4d</td>
<td align="left">Sheshan International GC</td>
<td align="left">Shanghai</td>
<td align="left">NA</td>
<td align="left">NA</td>
<td align="left">CHN</td>
</tr>
<tr class="even">
<td align="left">b5bc63f2-fb56-48c8-870b-6cf2b9d2ec92</td>
<td align="left">Sanderson Farms Championship</td>
<td align="left">stroke</td>
<td align="right">4200000</td>
<td align="right">756000</td>
<td align="left">USD</td>
<td align="right">300</td>
<td align="left">2016-10-27</td>
<td align="left">2016-10-30</td>
<td align="left">US/Central</td>
<td align="left">3d7993d0-7448-4670-b793-f7d7dfe03ed1</td>
<td align="left">Country Club of Jackson</td>
<td align="left">Jackson</td>
<td align="left">MS</td>
<td align="left">39211</td>
<td align="left">USA</td>
</tr>
<tr class="odd">
<td align="left">b192c217-7793-4081-8a8e-95c497f1befc</td>
<td align="left">Shriners Hospitals for Children Open</td>
<td align="left">stroke</td>
<td align="right">6600000</td>
<td align="right">1188000</td>
<td align="left">USD</td>
<td align="right">500</td>
<td align="left">2016-11-03</td>
<td align="left">2016-11-06</td>
<td align="left">US/Pacific</td>
<td align="left">4743d27b-678f-496f-a6b3-b90549955a14</td>
<td align="left">TPC Summerlin</td>
<td align="left">Las Vegas</td>
<td align="left">NV</td>
<td align="left">89134</td>
<td align="left">USA</td>
</tr>
<tr class="even">
<td align="left">b4f159c1-9984-4079-b98c-056c6f1cd4db</td>
<td align="left">OHL Classic at Mayakoba</td>
<td align="left">stroke</td>
<td align="right">7000010</td>
<td align="right">1260001</td>
<td align="left">USD</td>
<td align="right">500</td>
<td align="left">2016-11-10</td>
<td align="left">2016-11-13</td>
<td align="left">America/Cancun</td>
<td align="left">8ab742a1-7cc9-49fa-a7c7-78aa172e34c8</td>
<td align="left">El Camaleon GC at the Mayakoba Resort</td>
<td align="left">Playa del Carmen</td>
<td align="left">NA</td>
<td align="left">NA</td>
<td align="left">MEX</td>
</tr>
</tbody>
</table>

From there, you can extract the final leaderboard with scoring information based on the the id of the tournament of interest.

``` r
# get leaderboard for first tournament on the 2017 PGA schedule
safeway_open_2017 <- getGolfTournamentLeaderboard(id = pga_schedule_2017$id[1], year = as.character(year(pga_schedule_2017$start_date[1])))

kable(head(safeway_open_2017), format = "markdown")
```

<table>
<colgroup>
<col width="5%" />
<col width="5%" />
<col width="7%" />
<col width="17%" />
<col width="4%" />
<col width="3%" />
<col width="4%" />
<col width="3%" />
<col width="3%" />
<col width="4%" />
<col width="3%" />
<col width="8%" />
<col width="8%" />
<col width="9%" />
<col width="9%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">first_name</th>
<th align="left">last_name</th>
<th align="left">country</th>
<th align="left">id</th>
<th align="right">position</th>
<th align="left">tied</th>
<th align="right">money</th>
<th align="right">points</th>
<th align="right">score</th>
<th align="right">strokes</th>
<th align="left">status</th>
<th align="left">round_one_strokes</th>
<th align="left">round_two_strokes</th>
<th align="left">round_three_strokes</th>
<th align="left">round_four_strokes</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Brendan</td>
<td align="left">Steele</td>
<td align="left">UNITED STATES</td>
<td align="left">5003f675-818b-410a-9f2e-1a860d152900</td>
<td align="right">1</td>
<td align="left">FALSE</td>
<td align="right">1080000</td>
<td align="right">500</td>
<td align="right">-18</td>
<td align="right">270</td>
<td align="left">NA</td>
<td align="left">67</td>
<td align="left">71</td>
<td align="left">67</td>
<td align="left">65</td>
</tr>
<tr class="even">
<td align="left">Patton</td>
<td align="left">Kizzire</td>
<td align="left">UNITED STATES</td>
<td align="left">3442d4dd-ecfa-43aa-9a01-7525e6f4952c</td>
<td align="right">2</td>
<td align="left">FALSE</td>
<td align="right">648000</td>
<td align="right">300</td>
<td align="right">-17</td>
<td align="right">271</td>
<td align="left">NA</td>
<td align="left">64</td>
<td align="left">71</td>
<td align="left">66</td>
<td align="left">70</td>
</tr>
<tr class="odd">
<td align="left">Johnson</td>
<td align="left">Wagner</td>
<td align="left">UNITED STATES</td>
<td align="left">d1bb74dd-720e-44d0-a35b-5fd619f8eefc</td>
<td align="right">3</td>
<td align="left">TRUE</td>
<td align="right">288000</td>
<td align="right">134</td>
<td align="right">-16</td>
<td align="right">272</td>
<td align="left">NA</td>
<td align="left">65</td>
<td align="left">67</td>
<td align="left">70</td>
<td align="left">70</td>
</tr>
<tr class="even">
<td align="left">Michael</td>
<td align="left">Kim</td>
<td align="left">SOUTH KOREA</td>
<td align="left">8593b951-98f9-4757-bed3-3e922c989d2f</td>
<td align="right">3</td>
<td align="left">TRUE</td>
<td align="right">288000</td>
<td align="right">134</td>
<td align="right">-16</td>
<td align="right">272</td>
<td align="left">NA</td>
<td align="left">73</td>
<td align="left">67</td>
<td align="left">65</td>
<td align="left">67</td>
</tr>
<tr class="odd">
<td align="left">Paul</td>
<td align="left">Casey</td>
<td align="left">ENGLAND</td>
<td align="left">e46760f3-85e4-4a31-be04-fa2d067760d0</td>
<td align="right">3</td>
<td align="left">TRUE</td>
<td align="right">288000</td>
<td align="right">134</td>
<td align="right">-16</td>
<td align="right">272</td>
<td align="left">NA</td>
<td align="left">64</td>
<td align="left">68</td>
<td align="left">71</td>
<td align="left">69</td>
</tr>
<tr class="even">
<td align="left">Scott</td>
<td align="left">Piercy</td>
<td align="left">UNITED STATES</td>
<td align="left">72b41f76-a9a1-4ff9-8364-b8a21129bd54</td>
<td align="right">3</td>
<td align="left">TRUE</td>
<td align="right">288000</td>
<td align="right">134</td>
<td align="right">-16</td>
<td align="right">272</td>
<td align="left">NA</td>
<td align="left">62</td>
<td align="left">67</td>
<td align="left">73</td>
<td align="left">70</td>
</tr>
</tbody>
</table>

That's all for now. Working on more functions as needed.
