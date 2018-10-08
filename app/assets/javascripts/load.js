var chargify = new Chargify();

chargify.load({
    // selector, where the iframe will be included on your page
    // optional if you have a `selector` on each and every field
    //selector: '#chargify1',

    //chjs_8mxqmp4xgpszq4hfpytxhvwv
    publicKey: 'chjs_scrmbjgb3484m2y7zpbcbby2',

    //nschimkanodash
    serverHost: 'https://nschimka-auth.chargify.com',

    type: 'card',

    hideCardImage: false,

    // required label/translation (i.e. '*') for required fields
    // Especially useful if you use 'fields' option
    requiredLabel: '*',

    // optional label/translation (i.e. '(optional field)')
    // optionalLabel: ' (this field is optional) ',

    // optional global styles that include iframe styles,
    // styles for fields, inputs, labels and messages
    style: {
        // to style an iframe, use the iframe's container selector
        '#chargify-form': { border: '1px dashed #ffc0cb57' },

        // `field` is the container for each field
        field: {
            backgroundColor: 'orange',
            paddingTop: '10px',
            paddingBottom: '10px',
            borderRadius: '5px'
        },

        // `input` is the input HTML element
        input: {
            backgroundColor: '#e6e6e6',
            paddingTop: '2px',
            paddingBottom: '1px'
        },

        // `label` is the label container
        label: {
            backgroundColor: 'lightblue',
            paddingTop: '2px',
            paddingBottom: '1px'
        },

        // `message` is the invalid message container
        message: {
            backgroundColor: 'red',
            color: 'white',
            paddingTop: '2px',
            paddingBottom: '1px'
        }
    },

    // use this option if you want to include each field
    // in the separate iframe
    fields: {

        firstName: {
            // selector, where the iframe with this field will be included
            // on your page
            selector: '#chargify1',

            // ot overrides default label
            label: 'FIRST NAME',

            // it overrides default placeholder
            placeholder: 'John',

            // if a given field is optional by default, you can make it required
            required: false,

            // it overrides default error message
            message: 'First name is not valid. Please update it.',

            // it overrides or defines max length
            maxlength: '30',

            // it overrides global styles for this field only
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        lastName: {
            selector: '#chargify1',
            label: 'LAST NAME',
            placeholder: 'Doe',
            required: false,
            message: 'This field is not valid. Please update it.',
            maxlength: '30',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        number: {
            selector: '#chargify2',
            label: 'Number',
            placeholder: 'xxxx xxxx xxxx xxxx',
            message: 'This field is not valid. Please update it.',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        month: {
            selector: '#chargify2',
            label: 'Mon',
            placeholder: 'mm',
            message: 'This field is not valid. Please update it.',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        year: {
            selector: '#chargify2',
            label: 'Year',
            placeholder: 'yyyy',
            message: 'This field is not valid. Please update it.',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        cvv: {
            selector: '#chargify2',
            label: 'CVV code',
            placeholder: '123',
            required: false,
            message: 'This field is not valid. Please update it.',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        /*
        bankName: {
            selector: '#chargify2',
            label: 'Bank Name',
            placeholder: 'My Bank',
            message: 'This field is not valid. Please update it.',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        routingNumber: {
            selector: '#chargify2',
            label: 'Routing',
            placeholder: '123412341234',
            message: 'This field is not valid. Please update it.',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        accountNumber: {
            selector: '#chargify2',
            label: 'Acct. Number',
            placeholder: '123412341234',
            message: 'This field is not valid. Please update it.',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        accountType: {
            selector: '#chargify2',
            label: 'Acct. Type',
            placeholder: 'Select One...',
            required: true,
            message: 'This field is not valid. Please update it.',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        accountHolderType: {
            selector: '#chargify2',
            label: 'Acct. Holder',
            placeholder: 'Select One...',
            required: true,
            message: 'This field is not valid. Please update it.',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },
        */

        address: {
            selector: '#chargify3',
            label: 'Address',
            placeholder: '1234 Hill St',
            required: false,
            message: 'This field is not valid. Please update it.',
            maxlength: '70',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        address2: {
            selector: '#chargify3',
            label: 'Address 2',
            placeholder: '1234 Hill St',
            required: false,
            message: 'This field is not valid. Please update it.',
            maxlength: '70',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        city: {
            selector: '#chargify3',
            label: 'City',
            placeholder: 'Austin',
            required: false,
            message: 'This field is not valid. Please update it.',
            maxlength: '30',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        state: {
            selector: '#chargify3',
            label: 'State',
            placeholder: 'TX',
            required: false,
            message: 'This field is not valid. Please update it.',
            maxlength: '2',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        zip: {
            selector: '#chargify3',
            label: 'Zip Code',
            placeholder: '10001',
            required: false,
            message: 'This field is not valid. Please update it.',
            maxlength: '5',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        },

        country: {
            selector: '#chargify4',
            label: 'Country',
            placeholder: 'US',
            required: false,
            message: 'This field is not valid. Please update it.',
            maxlength: '30',
            style: {
                field: {
                    backgroundColor: '#ffdfdf',
                    padding: '3px',
                    borderRadius: '5px'
                },
                input: {
                    backgroundColor: '#fdfde1',
                    paddingTop: '2px',
                    paddingBottom: '1px'
                },
                label: {
                    paddingTop: '2px',
                    paddingBottom: '1px',
                    fontSize: '11px'
                },
                message: { paddingTop: '2px', paddingBottom: '1px' }
            }
        }
    }
});