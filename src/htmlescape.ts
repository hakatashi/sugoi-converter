import {AllHtmlEntities} from 'html-entities'

const entities = new AllHtmlEntities();

export const encode = (data:Buffer) => {
	return entities.encodeNonUTF(data.toString('utf-8'));
};

export const decode = (text:string) => {
	return Buffer.from(entities.decode(text), 'utf-8');
};
