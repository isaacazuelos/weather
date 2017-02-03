# Weather data notes

I'm pulling data from the the government's [site][] for the city I live in
(Calgary.)

[site]: https://weather.gc.ca/city/pages/ab-52_metric_e.html

Here's some information on what feilds seem useful for this project.

- `updated`
- entry 0 is about watches and warnings
    - it has it's own `updated`
- entry 1 is current conditions.
    - it has it's own `updated`, so maybe a trend...
	- specifics are in HTML.
	
rather than rely on entry positions, we should probably select by `category`
`term`.

``` sh
$ weather
Current Conditions: Sunny, -12.2 C
```

## Implementation Plan

1. Get it printing from the hard-coded URL
2. have it load the url from `.forecast`
3. implement `init` to save the url.
4. Have it print a forecast with `--forecast`
5. Print the full details with `--details`
