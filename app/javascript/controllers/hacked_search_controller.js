import { Controller } from '@hotwired/stimulus'

import algoliasearch from 'algoliasearch/lite';
import { autocomplete, getAlgoliaResults } from '@algolia/autocomplete-js';

export default class extends Controller {
  static targets = [ ]
  static values = { 
    locale: String,
    debug: Boolean,
    placeholder: String,
    clear: String,
    cancel: String,
    submit: String,
  }

  open() {
    this.autocomplete.setIsOpen(true)
  }

  connect() {
    let locale = this.hasLocaleValue ? this.localeValue : 'en'

    const searchClient = algoliasearch(
      'XNJHVMTGMF',
      '765db6917d5c17449984f7c0067ae04c'
    );

    let that = this
    
    this.autocomplete = autocomplete({
      container: '#autocomplete',
      plugins: [
        ],
      debug: this.debugValue, 
      openOnFocus: true,
      placeholder: this.placeholderValue,
      translations: {
        clearButtonTitle: this.clearValue, // defaults to 'Clear'
        detachedCancelButtonText: this.cancelValue, // defaults to 'Cancel'
        submitButtonTitle: this.submitValue, // defaults to 'Submit'

      },
      detachedMediaQuery: "(max-width: 5000px)",
      getSources({ query }) {
        if(query.length == 0) { return [] };
        
        return [

          {
            sourceId: 'areas',
            getItems() {
              return getAlgoliaResults({
                searchClient,
                queries: [
                  {
                    indexName: 'Area',
                    query,
                    params: {
                      hitsPerPage: 3,
                      highlightPreTag: '<strong>',
                      highlightPostTag: '</strong>',
                    },
                  },
                ],
              });
            },

            templates: {
              item({ item, createElement }) {
                return createElement('div', {
                  dangerouslySetInnerHTML: {
                    __html: `<span class="">
                    ${item._highlightResult.name.value}
                    </span>`,
                  },
                });
              },
              // footer({ items, createElement }) {
              //   if (items.length === 0) {
              //     return null;
              //   }
              //   return createElement('div', {
              //     dangerouslySetInnerHTML: {
              //       __html: `<div class="">
              //         <div class="flex items-center my-1" aria-hidden="true">
              //           <div class="w-full border-t border-green-600"></div>
              //         </div>
              //       </div>`,
              //     },
              //   });
              // },
            },

            getItemUrl({ item }) {
              return `/${locale}/redirects/new?area_id=${item.objectID}`
            },

            onSelect({ item }) {
              // console.log(item)
              const event = new CustomEvent("gotoarea", 
                { detail: 
                  { 
                    id: item.objectID, 
                    name: item.name, 
                    south_west_lat: item.bounds.south_west.lat,
                    south_west_lon: item.bounds.south_west.lng,
                    north_east_lat:  item.bounds.north_east.lat,
                    north_east_lon:  item.bounds.north_east.lng,
                  } 
                }
              );
              window.dispatchEvent(event);

              that.autocomplete.setIsOpen(false)

              // document.location.href=`/${locale}/redirects/new?area_id=${item.objectID}`
            },

          },


          {
            sourceId: 'problems',
            getItems() {
              return getAlgoliaResults({
                searchClient,
                queries: [
                  {
                    indexName: 'Problem',
                    query,
                    params: {
                      hitsPerPage: 10,
                      highlightPreTag: '<strong>',
                      highlightPostTag: '</strong>',
                    },
                  },
                ],
              });
            },

            templates: {
              item({ item, createElement }) {

                const colorMapping = {
                      "yellow":   "#FFCC02",
                      "purple":   "#D783FF",
                      "orange":   "#FF9500",
                      "green":    "#77C344",
                      "blue":     "#017AFF",
                      "skyblue":  "#5AC7FA",
                      "salmon":   "#FDAF8A",
                      "red":      "#FF3B2F",
                      "black":    "#000000",
                      "white":    "#FFFFFF",
                    }

                function bgColor(circuit_color) {
                  return colorMapping[circuit_color] || "rgb(80% 80% 80%)"
                }

                function textColor(circuit_color) {
                  return (circuit_color == "white") ? "#333" : "#FFF"
                }

                return createElement('div', {
                  dangerouslySetInnerHTML: {
                    __html: `<div class="flex justify-between items-center">
                      <div class="flex items-center">
                        <span style="background: ${bgColor(item.circuit_color)}; color: ${textColor(item.circuit_color)}" class="rounded-full h-6 w-6 leading-6 inline-flex justify-center flex-shrink-0">
                        ${item.circuit_number || "&nbsp;"}
                        </span>
                        <span class="ml-2">
                        ${item._highlightResult.name.value}
                        </span>
                        <span class="ml-2 text-gray-400">
                        ${item.grade}
                        </span>
                      </div>
                      <span class="ml-2 text-gray-400 flex-shrink-0">
                        ${item.area_name}
                      </span>
                    </div>`,
                  },
                });
              },
              // header({ items, createElement }) {
              //   if (items.length === 0) {
              //     return null;
              //   }
              //   return createElement('div', {
              //     dangerouslySetInnerHTML: {
              //       __html: `<span class="text-green-600">
              //       Voies
              //       </span>`,
              //     },
              //   });
              // },
              // noResults() {
              //   return 'No results';
              // },
            },

            getItemUrl({ item }) {
              return `/${locale}/redirects/new?problem_id=${item.objectID}`
            },
            onSelect({ item }) {
              // console.log(item.objectID)
              // console.log(item)
              const event = new CustomEvent("gotoproblem", { detail: { id: item.objectID, name: item.name, grade: item.grade, lat: item._geoloc.lat, lon: item._geoloc.lng } });
              window.dispatchEvent(event);

              that.autocomplete.setIsOpen(false)

              // document.location.href=`/${locale}/redirects/new?problem_id=${item.objectID}`
            },

          },
        ];
      },
    });
  }
}